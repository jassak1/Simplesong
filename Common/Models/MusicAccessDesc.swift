//
//  MusicAccessDesc.swift
//  Simplesong
//
//  Created by Adam Jassak on 06/08/2023.
//

import Foundation

/// Custom Enum mapping Apple Music Access statuses to String representations
enum MusicAccessDesc: String {
    case notDetermined = "Not Determined"
    case denied = "Denied"
    case authorized = "Authorized"
}
