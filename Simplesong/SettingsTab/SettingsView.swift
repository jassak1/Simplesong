//
//  SettingsView.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.requestReview) var requestReview
    @Bindable var vm: SettingsVM
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            ZStack {
                List {
                    Section(content: {
                        HStack {
                            getLabel(name: L10n.twitter)
                            Spacer()
                            Link(destination: vm.xUrl) {
                                Text(AppConstant.xHandel)
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            getLabel(name: L10n.mail)
                            Spacer()
                            Link(destination: vm.mailUrl) {
                                Text(AppConstant.mailHandel)
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            getLabel(name: L10n.appstore)
                            Spacer()
                            Button(action: {
                                requestReview()
                            }, label: {
                                Text(L10n.giveReview)
                            }) .foregroundStyle(.gray)
                        }
                        Button(action: {
                            vm.navPath.append(SettingsNavPath.requestScreen)
                        }, label: {
                            HStack {
                                monoText(L10n.requestListLink)
                                Spacer()
                                Image(systemName: AppConstant.rightIcon)
                            }
                        }).foregroundStyle(.white)
                        Button(action: {
                            vm.navPath.append(SettingsNavPath.aboutScreen)
                        }, label: {
                            HStack {
                                monoText(L10n.about)
                                Spacer()
                                Image(systemName: AppConstant.rightIcon)
                            }
                        }).foregroundStyle(.white)
                        Button(action: {
                            vm.navPath.append(SettingsNavPath.faqScreen)
                        }, label: {
                            HStack {
                                monoText(L10n.faq)
                                Spacer()
                                Image(systemName: AppConstant.rightIcon)
                            }
                        }).foregroundStyle(.white)
                    }, header: {
                        monoText(L10n.simplesong)
                    }).listRowBackground(Color.black)
                    Section {
                        monoText("\(L10n.version): \(vm.appVersion)")
                    }.listRowBackground(Color.black)
                }.listStyle(.grouped)
            }.navigationTitle(L10n.settings)
                .dynamicTypeSize(.medium)
                .navigationDestination(for: SettingsNavPath.self) { item in
                    switch item {
                    case .aboutScreen:
                        vm.router.showAboutView()
                    case .faqScreen:
                        vm.router.showFaqView()
                    case .requestScreen:
                        vm.router.showRequestView()
                    }
                }
        }
    }

    /// Custom SwiftUI Label View
    func getLabel(name: String) -> some View {
        Label(title: {
            monoText(name)
        }, icon: {
            Image(name)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
        })
    }

    init() {
        self.vm = DI.shared.settingsVm
    }
}

#Preview {
    SettingsView()
}
