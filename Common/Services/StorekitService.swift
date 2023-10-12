//
//  StorekitService.swift
//  Simplesong
//
//  Created by Adam Jassak on 06/08/2023.
//

import Foundation
import StoreKit
import WidgetKit

/// Enum describing StoreKit States
enum SkListenerStates: String {
    case unverified = "Unverified"
    case pending = "Pending"
    case userCancelled = "User Cancelled"
    case unknown = "Unknown"
}

/// Protocol providing blueprint for SkListener
protocol StorekitServiceProto {
    /// Method responsible for retrieving Simplesong Premium product
    ///
    /// - Returns: Optional value of `Product` type
    func fetchProduct() async throws -> Product?

    /// Method responsible for listening to transaction updates (ran immediately when app starts)
    ///
    /// - Returns: Task<Void, Error>
    func transactionListener() -> Task<Void, Error>

    /// Method responsible for purchassing the Item (trigerred by Purchase button)
    ///
    /// - Parameters:
    ///     - item: Optional value of `Product` type
    func purchaseItem(item: Product?) async throws

    /// Method responsible for restoring purchased Item (trigerred by Restore purchase button)
    func restorePurchase() async
}

/// SkListener class responsible for performing In App purchases actions
class StorekitService: StorekitServiceProto {

    // MARK: - public methods

    @MainActor
    func fetchProduct() async throws -> Product? {
        let products = try await Product.products(for: [AppConstant.iapProductId])
        let product = products.first
        return product
    }

    func transactionListener() -> Task<Void, Error> {
        Task {
            for await result in Transaction.updates {
                switch result {
                case .verified(let transaction):
                    premiumPurchased()
                    await transaction.finish()
                case .unverified:
                    print(SkListenerStates.unverified.rawValue)
                }
            }
        }
    }

    @MainActor
    func purchaseItem(item: Product?) async throws {
        let result = try await item?.purchase()
        switch result {
        case .pending:
            print(SkListenerStates.pending.rawValue)
        case .userCancelled:
            print(SkListenerStates.userCancelled.rawValue)
        case .success(let verification):
            switch verification {
            case .verified(let transaction):
                premiumPurchased()
                await transaction.finish()
            case .unverified:
                print(SkListenerStates.unverified.rawValue)
            }
        default:
            print(SkListenerStates.unknown.rawValue)
        }
    }

    @MainActor
    func restorePurchase() async {
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                if transaction.productID == AppConstant.iapProductId {
                    premiumPurchased()
                    withUnsafeCurrentTask {
                        $0?.cancel()
                    }
                }
                await transaction.finish()
            case .unverified:
                print(SkListenerStates.unverified.rawValue)
            }
        }
    }

    // MARK: - private methods

    /// Method responsible for updating UserDefault flag indicating that Premium has been purchased
    /// Once purchased, method also reloads all widget timelines to update Standings to current season
    private func premiumPurchased() {
        UserDefaults.setValue(for: .premiumUnlocked, setValue: true)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
