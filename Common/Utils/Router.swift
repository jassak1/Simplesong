//
//  Router.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

/// Router protocol defining SwiftUI Views of main app
protocol RouterSimplesong {
    func showHomeView() -> HomeView
    func showHowToView() -> HowToView
    func showSettingsView() -> SettingsView
    func showWorkshopView() -> WorkshopView
    func showAboutView() -> AboutView
    func showFaqView() -> FAQView
    func showRequestView() -> RequestView
}

/// Router protocol defining SwiftUI Views of widgets extension
protocol RouterSimplesongWidget: Hashable {
    func showSimpleSongWidget(entry: SimpleEntry) -> SimplesongView

    func showTheControlWidget(entry: SimpleEntry) -> TheControlView

    func showTheButtonWidget(entry: SimpleEntry) -> TheButtonView

    func showShuffleWidget(entry: SimpleEntry) -> ShuffleView

    func showRectangleWidget(entry: SimpleEntry) -> RectangleView

    func showJustArtworkWidget(entry: SimpleEntry) -> JustArtworkView

    func showWidgampWidget(entry: SimpleEntry) -> WidgampView

    func showBoomboxWidget(entry: SimpleEntry) -> BoomboxView

    func showVisualizerSmWidget(entry: GifEntry) -> VisualizerSmView

    func showVisualizerMdWidget(entry: GifEntry) -> VisualizerMdView

    func showRadioModernMdWidget(entry: RadioEntry) -> RadioMdModernView

    func showRadioRetroMdWidget(entry: RadioEntry) -> RadioMdRetroView
}

/// Router type holding all SwiftUI Views instances
struct Router { }

/// Router extension conforming to `RouterSimplesong`
extension Router: RouterSimplesong {
    func showHomeView() -> HomeView {
        HomeView()
    }

    func showHowToView() -> HowToView {
        HowToView()
    }

    func showSettingsView() -> SettingsView {
        SettingsView()
    }

    func showWorkshopView() -> WorkshopView {
        WorkshopView()
    }

    func showAboutView() -> AboutView {
        AboutView()
    }

    func showFaqView() -> FAQView {
        FAQView()
    }

    func showRequestView() -> RequestView {
        RequestView()
    }
}

/// Router extension conforming to `RouterSimplesongWidget`
extension Router: RouterSimplesongWidget {
    func showSimpleSongWidget(entry: SimpleEntry) -> SimplesongView {
        SimplesongView(entry: entry)
    }
    
    func showTheControlWidget(entry: SimpleEntry) -> TheControlView {
        TheControlView(entry: entry)
    }

    func showTheButtonWidget(entry: SimpleEntry) -> TheButtonView {
        TheButtonView(entry: entry)
    }

    func showShuffleWidget(entry: SimpleEntry) -> ShuffleView {
        ShuffleView(entry: entry)
    }

    func showRectangleWidget(entry: SimpleEntry) -> RectangleView {
        RectangleView(entry: entry)
    }

    func showJustArtworkWidget(entry: SimpleEntry) -> JustArtworkView {
        JustArtworkView(entry: entry)
    }

    func showWidgampWidget(entry: SimpleEntry) -> WidgampView {
        WidgampView(entry: entry)
    }

    func showBoomboxWidget(entry: SimpleEntry) -> BoomboxView {
        BoomboxView(entry: entry)
    }

    func showVisualizerSmWidget(entry: GifEntry) -> VisualizerSmView {
        VisualizerSmView(entry: entry)
    }

    func showVisualizerMdWidget(entry: GifEntry) -> VisualizerMdView {
        VisualizerMdView(entry: entry)
    }

    func showRadioModernMdWidget(entry: RadioEntry) -> RadioMdModernView {
        RadioMdModernView(entry: entry)
    }

    func showRadioRetroMdWidget(entry: RadioEntry) -> RadioMdRetroView {
        RadioMdRetroView(entry: entry)
    }
}
