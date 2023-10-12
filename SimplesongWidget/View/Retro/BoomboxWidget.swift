//
//  BoomboxWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 27/07/2023.
//

import SwiftUI
import MusicKit
import WidgetKit

struct BoomboxView: View {
    let entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    lowSpeakerImage(flipped: true)
                    Asset.boomboxHeader.swiftUIImage
                        .resizable()
                        .scaledToFit()
                    lowSpeakerImage(flipped: false)
                }.padding(-10)
                    .frame(maxHeight: .infinity, alignment: .top)
                HStack {
                    bassSpeakerImage(flipped: false)
                    Spacer()
                    VStack(spacing: 0) {
                        monoText(entry.songInfo.currentSongTitle)
                            .font(.caption)
                            .foregroundStyle(vm.boomboxWorkshop.personalAppearance ? vm.boomboxWorkshop.fgColor : .black)
                        ZStack {
                            sideButton(rightSide: false)
                            sideButton(rightSide: true)
                            Button(intent: SimpleIntent(playerAction: entry.songInfo.isPlaying ? .pause : .play),
                                   label: {
                                Image(uiImage: entry.songInfo.currentSongImage)
                                    .resizable()
                                    .scaledToFit()
                                    .overlay(Rectangle()
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(.gray))
                                    .overlay(
                                        Image(systemName:
                                                entry.songInfo.isPlaying ?
                                              AppConstant.pauseIcon :
                                                AppConstant.playIcon)
                                            .font(.largeTitle)
                                            .imageScale(.large)
                                            .shadow(color: .black, radius: 5))
                            }).buttonStyle(.plain)
                        }
                    }
                    Spacer()
                    bassSpeakerImage(flipped: true)
                }
                .padding(-5)
                .frame(maxHeight: .infinity)
            }
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay()
            }
        }.foregroundStyle(vm.boomboxWorkshop.personalAppearance ?
                          vm.boomboxWorkshop.detailColor : .white)
            .containerBackground(for: .widget) {
                Asset.boomboxColor.swiftUIColor
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwftUI View returning low speaker image
    func lowSpeakerImage(flipped: Bool) -> some View {
        Asset.lowSpeaker.swiftUIImage
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(flipped ? 180 : 0))
            .frame(width: 50)
    }

    /// Custom SwftUI View returning bass speaker image
    func bassSpeakerImage(flipped: Bool) -> some View {
        Asset.bassSpeaker.swiftUIImage
            .resizable()
            .scaledToFit()
            .rotation3DEffect(
                .degrees(flipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .frame(height: 80)
    }

    /// Custom SwiftUI View returning side buttons
    func sideButton(rightSide: Bool) -> some View {
        Button(intent: SimpleIntent(playerAction: rightSide ? .forward : .backward),
               label: {
            Image(uiImage: rightSide ? entry.songInfo.nextSongImage :
                    entry.songInfo.prevSongImage)
                .resizable()
                .scaledToFit()
                .scaleEffect(0.8)
                .shadow(color: .gray, radius: 10)
        }).offset(x: rightSide ? 40 : -40)
        .buttonStyle(.plain)
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// Boombox Widget
struct BoomboxWidget: Widget {
    let kind: String = WidgetKind.boombox.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            BoomboxView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.boombox.rawValue)
                            .description(L10n.boomboxDesc)
    }
}

#Preview(as: .systemMedium) {
    BoomboxWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}
