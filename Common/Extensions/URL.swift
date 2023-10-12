//
//  URL.swift
//  Simplesong
//
//  Created by Adam Jassak on 28/07/2023.
//

import Foundation

extension URL {
    /// Property providing URL path referring to AppGroup's documents directory
    static let containerDirectory = FileManager.default.containerURL(
        forSecurityApplicationGroupIdentifier: AppConstant.appGroupContainer)
}
