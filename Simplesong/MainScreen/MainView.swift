//
//  MainView.swift
//  Simplesong
//
//  Created by Adam Jassak on 13/07/2023.
//

import SwiftUI
import MusicKit
import WidgetKit

struct MainView: View {
    let viewModel: MainVM
    var body: some View {
        TabView {
            viewModel.router.showHomeView()
                .tabItem {
                    Label(
                        title: { Text(L10n.home) },
                        icon: { Image(systemName: AppConstant.homeIcon) }
                    )
                }
            viewModel.router.showHowToView()
                .tabItem {
                    Label(
                        title: { Text(L10n.howTo) },
                        icon: { Image(systemName: AppConstant.howToIcon) }
                    )
                }
            viewModel.router.showSettingsView()
                .tabItem {
                    Label(
                        title: { Text(L10n.settings) },
                        icon: { Image(systemName: AppConstant.settingsIcon) }
                    )
                }
        }.dynamicTypeSize(.medium)
            .onOpenURL {
                viewModel.handleDeepLink(url: $0)
            }
    }
    init() {
        viewModel = DI.shared.mainVm
    }
}

#Preview {
    MainView()
}
