//
//  IapView.swift
//  Simplesong
//
//  Created by Adam Jassak on 06/08/2023.
//

import SwiftUI
import StoreKit

struct IapView: View {
    @Environment(\.dismiss) var hideSheet
    @Bindable var vm: SettingsVM
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black,
                                    Asset.accentColor.swiftUIColor.opacity(0.2)],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack {
                    OptionallyHidden(isHidden: !vm.navPath.isEmpty) {
                        Button(action: {
                           hideSheet()
                        }, label: {
                            Image(systemName: AppConstant.downIcon)
                                .font(.largeTitle)
                        }).padding()
                    }
                    monoText(L10n.simplePremium)
                        .foregroundStyle(Asset.accentColor.swiftUIColor)
                        .font(.title)
                        .fontWeight(.bold)
                    monoText(L10n.unlockAll)
                        .font(.subheadline)
                    Asset.iapImage.swiftUIImage
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 10) {
                        Label(title: {
                            monoText(L10n.unlockOne)
                        }, icon: {
                            Image(systemName: AppConstant.handPointIcon)
                                .foregroundStyle(.green)
                        })
                        Label(title: {
                            monoText(L10n.unlockTwo)
                        }, icon: {
                            Image(systemName: AppConstant.handPointIcon)
                                .foregroundStyle(.green)
                        })
                        Label(title: {
                            monoText(L10n.unlockThree)
                        }, icon: {
                            Image(systemName: AppConstant.handPointIcon)
                                .foregroundStyle(.green)
                        })
                    }.fontWeight(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 50)
                    Text("\(L10n.premiumStatus) \(vm.skUnlocked ? L10n.unlocked : L10n.locked)")
                        .padding(.bottom)
                    Spacer()
                    HStack {
                        Link(destination: vm.privacyUrl,
                             label: {
                            Text(L10n.privacyPolicy)
                        })
                        Text(L10n.and)
                        Link(destination: vm.termsUrl,
                             label: {
                            Text(L10n.termsUse)
                        })
                    }
                    Button(action: {
                        vm.purchasePremium()
                    }, label: {
                        monoText("\(L10n.buyNow) \(vm.skPrice)")
                    }).padding()
                        .font(.title)
                        .fontWeight(.bold)
                        .background(Asset.darkRed.swiftUIColor)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Button(action: {
                        vm.restorePremium()
                    }, label: {
                        Text(L10n.restorePurchase)
                    }).foregroundStyle(Asset.darkRed.swiftUIColor)
                        .padding(.bottom, 30)
                }.padding(.horizontal)
            }.scrollIndicators(.hidden)
                .alert(L10n.purchaseRestored, isPresented: $vm.showAlert) {
                    Button(L10n.ok, role: .cancel) {}
                }
        }.dynamicTypeSize(.medium)
    }

    init() {
        vm = DI.shared.settingsVm
    }
}

#Preview {
    IapView()
}
