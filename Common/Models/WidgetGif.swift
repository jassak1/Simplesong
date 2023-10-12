//
//  WidgetGif.swift
//  Simplesong
//
//  Created by Adam Jassak on 09/08/2023.
//

import Foundation

/// Custom enum defining possible Widget GIFs
enum WidgetGif: String, CaseIterable {
    case badger = "Badger"
    case cat = "Cat"
    case peterGriffin = "Peter Griffin"
    case pacman = "Pacman"
    case vincent = "Vincent"
    case pixelCat = "PixelCat"
    case cloud = "Cloud"
    case dog = "Dog"

    /// Static property providing array of Small WidgetGif
    static var smallGifs: [Self] = [.badger, .cat, .peterGriffin, .vincent]

    /// Static property providing array of Medium WidgetGif
    static var mediumGifs: [Self] = Self.allCases.filter { !smallGifs.contains($0) }

    /// Static method responsible for providing array of WidgetGif conditionally
    static func getGifList(widgetKind: WidgetKind) -> [Self] {
        if widgetKind == .visualizerSm {
            return WidgetGif.smallGifs
        } else {
            return WidgetGif.mediumGifs
        }
    }
}
