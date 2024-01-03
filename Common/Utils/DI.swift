//
//  DI.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import Foundation

/// Dependency Injection
struct DI {
    // MARK: - Singleton
    static let shared = DI()

    // MARK: - Private properties
    private var router: Router
    private var musicService: MusicServiceProto

    // MARK: - Public properties
    let mainVm: MainVM
    let homeVm: HomeVM
    let howToVm: HowToVM
    let settingsVm: SettingsVM

    let simpleIntentVm: SimpleIntentVM
    let simpleProviderVm: SimpleProviderVM
    let widgetSharedVm: WidgetSharedVM
    let radioIntentVm: RadioIntentVM

    init() {
        router = Router()
        musicService = MusicService()
        homeVm = HomeVM(router: router, musicService: musicService)
        mainVm = MainVM(router: router)
        howToVm = HowToVM(router: router)
        settingsVm = SettingsVM(router: router,
                                musicService: musicService)
        simpleIntentVm = SimpleIntentVM(musicService: musicService)
        simpleProviderVm = SimpleProviderVM(musicService: musicService)
        widgetSharedVm = WidgetSharedVM(musicService: musicService)
        radioIntentVm = RadioIntentVM()
    }
}
