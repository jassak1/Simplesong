//
//  FileManager.swift
//  Simplesong
//
//  Created by Adam Jassak on 28/07/2023.
//

import UIKit

extension FileManager {
    /// Static method responsible for storing UIImage using FileManager's shared container
    static func storeImage(image: UIImage, fileName: DefaultKey) {
        guard let containerUrl = URL.containerDirectory else { return }
        let fullPath = containerUrl.appending(path: fileName.rawValue)
        let imageData = image.pngData() ?? Data()
        do {
            try imageData.write(to: fullPath)
        } catch {
            print(error)
        }
    }

    /// Static method responsible for retrieving UIImage from FileManager's shared container
    static func getImage(fileName: DefaultKey) -> UIImage? {
        guard let containerUrl = URL.containerDirectory else { return nil }
        let fullPath = containerUrl.appending(path: fileName.rawValue)
        do {
            let storedImage = try Data(contentsOf: fullPath)
            return UIImage(data: storedImage) ?? UIImage()
        } catch {
            print(error)
            return nil
        }
    }
}
