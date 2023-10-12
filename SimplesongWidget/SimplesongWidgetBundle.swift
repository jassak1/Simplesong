//
//  SimplesongWidgetBundle.swift
//  SimplesongWidget
//
//  Created by Adam Jassak on 16/07/2023.
//

import WidgetKit
import SwiftUI

@main
struct SimplesongWidgetBundle: WidgetBundle {
    var body: some Widget {
        ModernWidgetBundle().body
        RetroWidgetBundle().body
    }
}

/// Widget Bundle of Modern designed Widgets
struct ModernWidgetBundle: WidgetBundle {
    var body: some Widget {
        SimplesongWidget()
        TheButtonWidget()
        RadioMdModernWidget()
        TheControlWidget()
    }
}


/// Widget Bundle of Retro designed Widgets
struct RetroWidgetBundle: WidgetBundle {
    var body: some Widget {
        ShuffleWidget()
        RadioMdRetroWidget()
        RectangleWidget()
        WidgampWidget()
        BoomboxWidget()
        JustArtworkWidget()
        VisualizerSmWidget()
        VisualizerMdWidget()
    }
}
