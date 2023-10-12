//
//  MainVM.swift
//  Simplesong
//
//  Created by Adam Jassak on 13/07/2023.
//

import SwiftUI

@Observable class MainVM {
    var router: Router = .init()

    /// Handles deepLink 'simplesong://show-retro'
    /// Depplink results in selecting the presented widgets to be ones from 'Retro' category
    func handleDeepLink(url: URL) {
        guard url.scheme == "simplesong" else {
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL")
            return
        }

        guard let action = components.host, action == "show-retro" else {
            print("Unknown URL, we can't handle this one!")
            return
        }

        DI.shared.homeVm.activeButton = .retro
    }

    init(router: Router) {
        self.router = router
    }
}
