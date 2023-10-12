//
//  WidgetWorkshop.swift
//  Simplesong
//
//  Created by Adam Jassak on 28/07/2023.
//

import SwiftUI
import Translucent

/// Widget Workshop protocol defining base properties
protocol WidgetWorkshopProto {
    var personalAppearance: Bool { get set }
    var bgColor: Color { get set }
    var fgColor: Color { get set }
    var detailColor: Color { get set }
    var size: Double { get set }
    var transparentBg: Bool { get set }
    var imagePosition: Int { get set }
    var image: UIImage { get set }
    var visualization: String { get set }
}

/// WidgetWorkshopProto extension with default values for all properties
extension WidgetWorkshopProto {
    var personalAppearance: Bool {
        get { true }
        set { }
    }
    var bgColor: Color {
        get { .black }
        set { }
    }
    var fgColor: Color {
        get { .black }
        set { }
    }
    var detailColor: Color {
        get { .black }
        set { }
    }
    var size: Double {
        get { 0.0 }
        set { }
    }
    var transparentBg: Bool {
        get { false }
        set { }
    }
    var imagePosition: Int {
        get { 10 }
        set { }
    }
    var image: UIImage {
        get { UIImage() }
        set { }
    }
    var visualization: String {
        get { String() }
        set { }
    }
}

/// Custom type providing appearance of SimpleSong Widget
struct SimpleSongWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .simpleCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .simpleCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .simpleBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .simpleBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .simpleFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .simpleFgColor, colorValue: newValue)
        }
    }
}

/// Custom type providing appearance of Shuffle Widget
struct ShuffleWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .shuffleCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .shuffleCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .shuffleBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .shuffleBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .shuffleFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .shuffleFgColor, colorValue: newValue)
        }
    }
    var detailColor: Color {
        get {
            UserDefaults.getColor(for: .shuffleDetailColor, defaultColor: .gray)
        }
        set {
            UserDefaults.setColor(for: .shuffleDetailColor, colorValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .shuffleTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .shuffleTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .shuffleImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .shuffleImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .shuffleImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .shuffleImage)
        }
    }
}

/// Custom type providing appearance of The Button Widget
struct TheButtonWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .theButtonCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .theButtonCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .theButtonBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .theButtonBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .theButtonFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .theButtonFgColor, colorValue: newValue)
        }
    }
    var size: Double {
        get {
            UserDefaults.getValue(for: .theButtonSize, defaultValue: 1.0)
        }
        set {
            UserDefaults.setValue(for: .theButtonSize, setValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .theButtonTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .theButtonTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .theButtonImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .theButtonImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .theButtonImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .theButtonImage)
        }
    }
}

/// Custom type providing appearance of The Control Widget
struct TheControlWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .theControlCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .theControlCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .theControlBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .theControlBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .theControlFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .theControlFgColor, colorValue: newValue)
        }
    }
    var size: Double {
        get {
            UserDefaults.getValue(for: .theControlSize, defaultValue: 1.0)
        }
        set {
            UserDefaults.setValue(for: .theControlSize, setValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .theControlTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .theControlTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .theControlImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .theControlImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .theControlImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .theControlImage)
        }
    }
}

/// Custom type providing appearance of Rectangle Widget
struct RectangleWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .rectangleCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .rectangleCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .rectangleBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .rectangleBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .rectangleFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .rectangleFgColor, colorValue: newValue)
        }
    }
    var detailColor: Color {
        get {
            UserDefaults.getColor(for: .rectangleDetailColor, defaultColor: .gray)
        }
        set {
            UserDefaults.setColor(for: .rectangleDetailColor, colorValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .rectangleTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .rectangleTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .rectangleImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .rectangleImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .rectangleImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .rectangleImage)
        }
    }
}

/// Custom type providing appearance of Just Artwork Widget
struct JustArtworkWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .justArtworkCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .justArtworkCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .justArtworkBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .justArtworkBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .justArtworkFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .justArtworkFgColor, colorValue: newValue)
        }
    }
    var detailColor: Color {
        get {
            UserDefaults.getColor(for: .justArtworkDetailColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .justArtworkDetailColor, colorValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .justArtworkTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .justArtworkTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .justArtworkImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .justArtworkImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .justArtworkImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .justArtworkImage)
        }
    }
}

/// Custom type providing appearance of Widgamp Widget
struct WidgampWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .widgapmpCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .widgapmpCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .widgapmpBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .widgapmpBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .widgapmpFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .widgapmpFgColor, colorValue: newValue)
        }
    }
    var detailColor: Color {
        get {
            UserDefaults.getColor(for: .widgapmpDetailColor, defaultColor: .orange)
        }
        set {
            UserDefaults.setColor(for: .widgapmpDetailColor, colorValue: newValue)
        }
    }
}

/// Custom type providing appearance of Boombox Widget
struct BoomboxWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .boomboxCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .boomboxCustomAppearance, setValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .boomboxFgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .boomboxFgColor, colorValue: newValue)
        }
    }
    var detailColor: Color {
        get {
            UserDefaults.getColor(for: .boomboxDetailColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .boomboxDetailColor, colorValue: newValue)
        }
    }
}

/// Custom type providing appearance of Visualizer Small Widget
struct VisualizerSmWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .visualizerSmCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .visualizerSmCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .visualizerSmBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .visualizerSmBgColor, colorValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .visualizerSmTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .visualizerSmTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .visualizerSmImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .visualizerSmImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .visualizerSmImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .visualizerSmImage)
        }
    }
    var visualization: String {
        get {
            UserDefaults.getValue(for: .visualizerSmVisualization, defaultValue: WidgetGif.badger.rawValue)
        }
        set {
            UserDefaults.setValue(for: .visualizerSmVisualization, setValue: newValue)
        }
    }
}

/// Custom type providing appearance of Visualizer Medium Widget
struct VisualizerMdWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .visualizerMdCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .visualizerMdCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .visualizerMdBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .visualizerMdBgColor, colorValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .visualizerMdTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .visualizerMdTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .visualizerMdImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .visualizerMdImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .visualizerMdImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .visualizerMdImage)
        }
    }
    var visualization: String {
        get {
            UserDefaults.getValue(for: .visualizerMdVisualization, defaultValue: WidgetGif.pixelCat.rawValue)
        }
        set {
            UserDefaults.setValue(for: .visualizerMdVisualization, setValue: newValue)
        }
    }
}

/// Custom type providing appearance of The Radio Modern Medium Widget
struct RadioModernMdWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .radioModernMdCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .radioModernMdCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .radioModernMdBgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .radioModernMdBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .radioModernMdFgColor, defaultColor: .white)
        }
        set {
            UserDefaults.setColor(for: .radioModernMdFgColor, colorValue: newValue)
        }
    }
    var size: Double {
        get {
            UserDefaults.getValue(for: .radioModernMdSize, defaultValue: 1.0)
        }
        set {
            UserDefaults.setValue(for: .radioModernMdSize, setValue: newValue)
        }
    }
    var transparentBg: Bool {
        get {
            UserDefaults.getValue(for: .radioModernMdTransparentBg, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .radioModernMdTransparentBg, setValue: newValue)
        }
    }
    var imagePosition: Int {
        get {
            UserDefaults.getValue(for: .radioModernMdImagePos, defaultValue: 10)
        }
        set {
            UserDefaults.setValue(for: .radioModernMdImagePos, setValue: newValue)
        }
    }
    var image: UIImage {
        get {
            return FileManager.getImage(fileName: .radioModernMdImage) ?? UIImage()
        }
        set {
            FileManager.storeImage(image: newValue, fileName: .radioModernMdImage)
        }
    }
}

/// Custom type providing appearance of the Retro Radio Medium Widget
struct RadioRetroMdWorkshop: WidgetWorkshopProto {
    var personalAppearance: Bool {
        get {
            UserDefaults.getValue(for: .radioRetroMdCustomAppearance, defaultValue: false)
        }
        set {
            UserDefaults.setValue(for: .radioRetroMdCustomAppearance, setValue: newValue)
        }
    }
    var bgColor: Color {
        get {
            UserDefaults.getColor(for: .radioRetroMdBgColor, defaultColor: Asset.radioFg.swiftUIColor)
        }
        set {
            UserDefaults.setColor(for: .radioRetroMdBgColor, colorValue: newValue)
        }
    }
    var fgColor: Color {
        get {
            UserDefaults.getColor(for: .radioRetroMdFgColor, defaultColor: .black)
        }
        set {
            UserDefaults.setColor(for: .radioRetroMdFgColor, colorValue: newValue)
        }
    }
    var detailColor: Color {
        get {
            UserDefaults.getColor(for: .radioRetroDetailColor, defaultColor: .gray)
        }
        set {
            UserDefaults.setColor(for: .radioRetroDetailColor, colorValue: newValue)
        }
    }
}
