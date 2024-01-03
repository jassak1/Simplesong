//
//  SettingsVM.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI
import StoreKit

@Observable class SettingsVM {
    // MARK: - Properties
    var router: Router = .init()
    var xUrl = URL(string: AppConstant.xUrl)!
    var mailUrl = URL(string: AppConstant.mailUrl)!
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? String()
    var navPath = NavigationPath()
    var accessDescription: String {
        get {
            switch musicService.authStatus {
            case .notDetermined:
                return MusicAccessDesc.notDetermined.rawValue
            case .denied:
                return MusicAccessDesc.denied.rawValue
            case .restricted:
                return "NA"
            case .authorized:
                return MusicAccessDesc.authorized.rawValue
            @unknown default:
                return "NA"
            }
        }
    }
    var accessFgColor: Color {
        get {
            switch musicService.authStatus {
            case .notDetermined:
                return .orange
            case .denied:
                return .red
            case .restricted:
                return .white
            case .authorized:
                return Asset.accentColor.swiftUIColor
            @unknown default:
                return .white
            }
        }
    }
    var musicService: MusicServiceProto = MusicService()
    var termsUrl = URL(string: AppConstant.termsUrl)!
    var privacyUrl = URL(string: AppConstant.privacyUrl)!
    var showAlert = false

    // MARK: - Initialiser
    init(router: Router,
         musicService: MusicServiceProto) {
        self.router = router
        self.musicService = musicService
    }
}
