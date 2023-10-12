//
//  SimplesongApp.swift
//  Simplesong
//
//  Created by Adam Jassak on 13/07/2023.
//

import SwiftUI
import WidgetKit

@main
struct SimplesongApp: App {
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            MainView()
                .onChange(of: scenePhase) {
                    WidgetCenter.shared.reloadAllTimelines()
                }
        }
    }
}
