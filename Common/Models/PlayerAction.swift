//
//  PlayerAction.swift
//  Simplesong
//
//  Created by Adam Jassak on 21/07/2023.
//

import Foundation
import AppIntents

/// Enum providing actions taken by music player and radio widgets
enum PlayerAction: String, AppEnum {
    case play
    case pause
    case forward
    case backward
    case restart
    case shuffle

    static var caseDisplayRepresentations: [PlayerAction : DisplayRepresentation] = [
        .play: "Play",
        .pause: "Pause",
        .forward: "Forward",
        .backward: "Backward",
        .restart: "Restart",
        .shuffle: "Shuffle"
    ]
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "PlayerAction"
}
