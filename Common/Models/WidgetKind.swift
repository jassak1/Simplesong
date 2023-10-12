//
//  WidgetKind.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import Foundation

/// Enum defining Widget Kinds
enum WidgetKind: String, CaseIterable {
    case simpleSong = "Simplesong Player"
    case radioModernMd = "Simple Radio Player"
    case shuffle = "Shuffle Player"
    case rectangle = "Rectangle Player"
    case radioRetroMd = "Retro Radio Player"
    case widgamp = "Widgamp Player"
    case boombox = "Boombox Player"
    case theButton = "The Button Player"
    case theControl = "The Control Player"
    case justArtwork = "Just Artwork Player"
    case visualizerSm = "Small Visualizer"
    case visualizerMd = "Medium Visualizer"

    /// Array holding `WidgetKind` of Modern category
    static let modernWidgets: [Self] = [.simpleSong, .theButton, .justArtwork,
                                        .theControl, .radioModernMd]
    /// Array holding `WidgetKind` of Retro category
    static let retroWidgets: [Self] = Self.allCases.filter { !modernWidgets.contains($0) }
    /// Array holding Small sized `WidgetKind`
    static let smallWidgets: [Self] = [.shuffle, .theButton, .visualizerSm]
    /// Array holding Medium sized `WidgetKind`
    static let mediumWidgets: [Self] = [.rectangle, .simpleSong, .widgamp,
                                        .boombox, .theControl, .justArtwork, .visualizerMd,
                                        .radioModernMd, .radioRetroMd]

    /// Array holding widgets allowing to update background color
    static let canEditBgColor: [Self] = [.simpleSong, .widgamp,
                                         .justArtwork, .rectangle, .shuffle,
                                         .theControl, .theButton, .visualizerSm, .visualizerMd,
                                         .radioModernMd, .radioRetroMd]

    /// Array holding widgets allowing to update foreground color
    static let canEditFgColor: [Self] = Self.allCases.filter { $0 != .visualizerSm || $0 != .visualizerMd }

    /// Array holding widgets allowing to update detail color
    static let canEditDetailColor: [Self] = [.boombox, .widgamp,
                                             .justArtwork, .rectangle, .shuffle,
                                             .radioRetroMd]

    /// Array holding widgets allowing to update size
    static let canEditSize: [Self] = [.theControl, .theButton, .radioModernMd]

    /// Array holding widgets allowing to update transparent image
    static let canEditTransparency: [Self] = [.justArtwork, .rectangle, .shuffle,
                                              .theControl, .theButton, .visualizerSm, .visualizerMd,
                                              .radioModernMd]

    /// Array holding widgets allowing to update visualization
    static let canEditVisualization: [Self] = [.visualizerSm, .visualizerMd]

    /// Array holding widgets allowing to select radio stations
    static let canSelectStations: [Self] = [.radioModernMd, .radioRetroMd]
}
