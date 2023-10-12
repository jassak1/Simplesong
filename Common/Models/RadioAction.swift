//
//  RadioAction.swift
//  Simplesong
//
//  Created by Adam Jassak on 05/09/2023.
//

import Foundation
import AppIntents

/// Enum providing actions taken by radio player and radio widgets
enum RadioAction: String, AppEnum {
    case play
    case pause
    case forward
    case backward

    static var caseDisplayRepresentations: [RadioAction : DisplayRepresentation] = [
        .play: "Play Radio",
        .pause: "Pause Radio",
        .forward: "Forward Radio",
        .backward: "Backward Radio",
    ]
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "RadioAction"
}
