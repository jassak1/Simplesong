//
//  RadioStations.swift
//  Simplesong
//
//  Created by Adam Jassak on 01/09/2023.
//

import Foundation

/// Custom type used for decoding Stations provided by Radio-Browser
struct RadioStations: Codable {
    let name: String
    let favicon: String
    let url: String
}
