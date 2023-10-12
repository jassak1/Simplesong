//
//  UserDefaults.swift
//  Simplesong
//
//  Created by Adam Jassak on 21/07/2023.
//

import SwiftUI

extension UserDefaults {
    /// Static property holding UserDefaults instance utilising App Group's shared container
    static let sharedSuite = UserDefaults(suiteName: AppConstant.appGroupContainer)

    /// Static method responsible for retrieving AppGroup's UserDefaults value associated with specified key
    static func getValue<T>(for key: DefaultKey, defaultValue: T) -> T {
        UserDefaults.sharedSuite?.object(forKey: key.rawValue) as? T ?? defaultValue
    }

    /// Static method responsible for setting AppGroup's UserDefaults value for specified key
    static func setValue<T>(for key: DefaultKey, setValue: T) {
        UserDefaults.sharedSuite?.set(setValue, forKey: key.rawValue)
    }

    /// Static method responsible for setting AppGroup's UserDefaults color for specified key
    static func setColor(for key: DefaultKey, colorValue: Color) {
        let baseColor = UIColor(colorValue)
        do {
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: baseColor, requiringSecureCoding: false)
            setValue(for: key, setValue: colorData)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Static method responsible for retrieving AppGroup's UserDefaults color associated with specified key
    static func getColor(for key: DefaultKey, defaultColor: Color) -> Color {
        let colorData = getValue(for: key, defaultValue: Data())
        let defaultColor = UIColor(defaultColor)
        do {
            let unarchivedUiColor = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
            return Color(uiColor: unarchivedUiColor ?? defaultColor)
        } catch {
            print(error.localizedDescription)
            return Color(uiColor: defaultColor)
        }
    }

    /// Static method responsible for storing custom type as Data in AppGroup's UserDefaults's specified key
    static func setData<T: Codable>(data: T, for key: DefaultKey) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            setValue(for: key, setValue: encodedData)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Static method responsible for getting custom type from AppGroup's UserDefaults's specified key
    static func getData<T: Codable>(for key: DefaultKey) -> T? {
        let storedData = getValue(for: key, defaultValue: Data())
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: storedData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
