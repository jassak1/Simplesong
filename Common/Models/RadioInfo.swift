//
//  RadioInfo.swift
//  Simplesong
//
//  Created by Adam Jassak on 02/09/2023.
//

import SwiftUI

/// Custom type holding Radio Information
struct RadioInfo {
    let station: String
    let isPlaying: Bool
    let stationOffset: CGFloat

    init(station: String,
         isPlaying: Bool,
         stationOffset: CGFloat) {
        self.station = station
        self.isPlaying = isPlaying
        self.stationOffset = stationOffset
    }

    init() {
        station = "Station Name"
        isPlaying = false
        stationOffset = -50
    }
}
