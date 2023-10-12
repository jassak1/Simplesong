//
//  JustArtworkWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 27/07/2023.
//

import SwiftUI
import MusicKit
import WidgetKit

struct JustArtworkView: View {
    let entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            skipButtonView(isRightButton: false)
            skipButtonView(isRightButton: true)
            Button(intent: SimpleIntent(playerAction: entry.songInfo.isPlaying ? .pause : .play),
                   label: {
                Image(uiImage: entry.songInfo.currentSongImage)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        ZStack {
                            Rectangle().stroke(lineWidth: 1).foregroundStyle(.gray)
                            Image(systemName: entry.songInfo.isPlaying ?
                                  AppConstant.pauseIcon :
                                    AppConstant.playIcon
                            )
                            .font(.largeTitle)
                            .imageScale(.large)
                            .shadow(color: .black, radius: 20)
                        })
            }).buttonStyle(.plain)
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay()
            }
        }.foregroundStyle(vm.justArtworkWorkshop.personalAppearance ? vm.justArtworkWorkshop.fgColor : .white)
            .containerBackground(for: .widget) {
                getBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI Skip Button View
    func skipButtonView(isRightButton: Bool) -> some View {
        Button(intent: SimpleIntent(playerAction: isRightButton ? .forward : .backward),
               label: {
            Asset.artwork.swiftUIImage
                .resizable()
                .scaledToFit()
                .overlay(
                    ZStack {
                        Rectangle().foregroundStyle(vm.justArtworkWorkshop.personalAppearance ? vm.justArtworkWorkshop.detailColor : .black)
                        Rectangle()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.gray)
                        Image(systemName: isRightButton ?
                              AppConstant.nextIcon :
                                AppConstant.prevIcon)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity,
                                   alignment: isRightButton ?
                                .trailing :
                                    .leading)
                            .padding()
                    })
        }).buttonStyle(.plain)
            .offset(x: isRightButton ? 70 : -70)
            .scaleEffect(0.8)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.justArtworkWorkshop.personalAppearance,
           vm.justArtworkWorkshop.transparentBg {
            Image(uiImage: vm.justArtworkWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.justArtworkWorkshop.personalAppearance {
            vm.justArtworkWorkshop.bgColor
        } else {
            Asset.almostBlack.swiftUIColor
            entry.songInfo.currentSongColor.opacity(0.7)
        }
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// Just Artwork Widget
struct JustArtworkWidget: Widget {
    let kind: String = WidgetKind.justArtwork.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            JustArtworkView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.justArtwork.rawValue)
                            .description(L10n.justArtworkDesc)
    }
}

#Preview(as: .systemMedium) {
    JustArtworkWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}

