//
//  WidgetSharedVM.swift
//  Simplesong
//
//  Created by Adam Jassak on 22/07/2023.
//

import SwiftUI
import MusicKit
import PhotosUI
import Translucent

/// Shared ViewModel for all Widget Views
@Observable class WidgetSharedVM {
    // MARK: - Workshop properties
    var simpleSongWorkshop = SimpleSongWorkshop()
    var shuffleWorkshop = ShuffleWorkshop()
    var theButtonWorkshop = TheButtonWorkshop()
    var theControlWorkshop = TheControlWorkshop()
    var rectangleWorkshop = RectangleWorkshop()
    var justArtworkWorkshop = JustArtworkWorkshop()
    var widgamptWorkshop = WidgampWorkshop()
    var boomboxWorkshop = BoomboxWorkshop()
    var visualizerSmWorkshop = VisualizerSmWorkshop()
    var visualizerMdWorkshop = VisualizerMdWorkshop()
    var radioModernMdWorkshop = RadioModernMdWorkshop()
    var radioRetroMdWorkshop = RadioRetroMdWorkshop()

    // MARK: - Other properties and functions
    /// MusicService property
    var musicService: MusicServiceProto = MusicService()
    /// Boolean flag indicating whether to show Widget Access Overlay
    var showAccessOverlay: Bool {
        get {
            musicService.authStatus != .authorized
        }
    }
    /// Boolean flag indicating whether to show Radio Setup Overlay
    var showRadioSetupOverlay: Bool {
        UserDefaults.getValue(for: .primaryStationRadio, defaultValue: "").isEmpty
    }

    // MARK: - Workshop View properties and functions
    /// Example `SimpleEntry` instance
    let exampleEntry = SimpleEntry(date: Date(),
                        songInfo: SongInfo(currentSongTitle: "Title of the Song",
                                           currentSongAuthor: "Song Author",
                                           currentSongImage: UIImage(asset: Asset.artwork) ?? UIImage(),
                                           currentSongColor: .gray,
                                           isPlaying: false,
                                           prevSongImage: UIImage(asset: Asset.artwork) ?? UIImage(),
                                           nextSongImage: UIImage(asset: Asset.artwork) ?? UIImage()),
                                   previewOnly: true)

    /// Example `GifEntry` instance
    let exampleGifEntry = GifEntry(date: Date(),
                                   frame: 0)

    /// Example `RadioEntry` instance
    let exampleRadioEntry = RadioEntry(date: Date(),
                                       radioInfo: RadioInfo(), previewOnly: true)


    /// `PhotosPickerItem` property used with photos picker in Workshop
    var photosItem: PhotosPickerItem? {
        get {
            PhotosPickerItem(itemIdentifier: String())
        }
        set {
            Task {
                let itemData = try? await newValue?.loadTransferable(type: Data.self)
                /// When invalid image is loaded, or Cancel button is pressed, previously picked image shall be used
                guard let itemUiImage = UIImage(data: itemData ?? Data()) else {
                    return
                }
                FileManager.storeImage(image: itemUiImage, fileName: .bgImage)
                photosImage = Image(uiImage: itemUiImage)
                invalidateCroppedImages()
            }
        }
    }

    /// Selected image from photos picker used withing Workshop
    var photosImage: Image = Image(uiImage: FileManager.getImage(fileName: .bgImage) ?? UIImage())

    // MARK: - Methods
    /// Method responsible for mapping Workshop properties based on workshop
    /// selected Widget. Used for updating appearance via WorskhopView
    func wAppearance(widget: WidgetKind) -> Binding<WidgetWorkshopProto> {
        switch widget {
        case .simpleSong:
            return Binding(get: {
                self.simpleSongWorkshop
            }, set: {
                self.simpleSongWorkshop = $0 as! SimpleSongWorkshop
            })
        case .shuffle:
            return Binding(get: {
                self.shuffleWorkshop
            }, set: {
                self.shuffleWorkshop = $0 as! ShuffleWorkshop
            })
        case .rectangle:
            return Binding(get: {
                self.rectangleWorkshop
            }, set: {
                self.rectangleWorkshop = $0 as! RectangleWorkshop
            })
        case .widgamp:
            return Binding(get: {
                self.widgamptWorkshop
            }, set: {
                self.widgamptWorkshop = $0 as! WidgampWorkshop
            })
        case .boombox:
            return Binding(get: {
                self.boomboxWorkshop
            }, set: {
                self.boomboxWorkshop = $0 as! BoomboxWorkshop
            })
        case .theButton:
            return Binding(get: {
                self.theButtonWorkshop
            }, set: {
                self.theButtonWorkshop = $0 as! TheButtonWorkshop
            })
        case .theControl:
            return Binding(get: {
                self.theControlWorkshop
            }, set: {
                self.theControlWorkshop = $0 as! TheControlWorkshop
            })
        case .justArtwork:
            return Binding(get: {
                self.justArtworkWorkshop
            }, set: {
                self.justArtworkWorkshop = $0 as! JustArtworkWorkshop
            })
        case .visualizerSm:
            return Binding(get: {
                self.visualizerSmWorkshop
            }, set: {
                self.visualizerSmWorkshop = $0 as! VisualizerSmWorkshop
            })
        case .visualizerMd:
            return Binding(get: {
                self.visualizerMdWorkshop
            }, set: {
                self.visualizerMdWorkshop = $0 as! VisualizerMdWorkshop
            })
        case .radioModernMd:
            return Binding(get: {
                self.radioModernMdWorkshop
            }, set: {
                self.radioModernMdWorkshop = $0 as! RadioModernMdWorkshop
            })
        case .radioRetroMd:
            return Binding(get: {
                self.radioRetroMdWorkshop
            }, set: {
                self.radioRetroMdWorkshop = $0 as! RadioRetroMdWorkshop
            })
        }
    }

    /// Method responsible for removing cropped images - to be used when background image is updated
    private func invalidateCroppedImages() {
        justArtworkWorkshop.image = UIImage()
        justArtworkWorkshop.imagePosition = 10

        rectangleWorkshop.image = UIImage()
        rectangleWorkshop.imagePosition = 10

        shuffleWorkshop.image = UIImage()
        shuffleWorkshop.imagePosition = 10
        
        theControlWorkshop.image = UIImage()
        theControlWorkshop.imagePosition = 10

        theButtonWorkshop.image = UIImage()
        theButtonWorkshop.imagePosition = 10

        visualizerMdWorkshop.image = UIImage()
        visualizerMdWorkshop.imagePosition = 10

        visualizerSmWorkshop.image = UIImage()
        visualizerSmWorkshop.imagePosition = 10

        radioModernMdWorkshop.image = UIImage()
        radioModernMdWorkshop.imagePosition = 10
    }

    init(musicService: MusicServiceProto) {
        self.musicService = musicService
    }
}

