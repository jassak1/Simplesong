//
//  SimplesongWidget.swift
//  SimplesongWidget
//
//  Created by Adam Jassak on 16/07/2023.
//

import WidgetKit
import MusicKit
import SwiftUI

/// Simplesong Widget View - Medium sized
struct SimplesongView: View {
    var entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            HStack {
                Group {
                    Image(uiImage: entry.songInfo.currentSongImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(ContainerRelativeShape())
                        .overlay {
                            ContainerRelativeShape()
                                .stroke(.gray, lineWidth: 2)
                        }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                Group {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            monoText(entry.songInfo.currentSongAuthor)
                                .fontWeight(.bold)
                            Text(entry.songInfo.currentSongTitle)
                                .font(.caption)
                        }.frame(maxHeight: .infinity)
                        OptionallyHidden(isHidden: !entry.songInfo.isPlaying) {
                            Text(Date()
                                .addingTimeInterval(-SystemMusicPlayer.shared.playbackTime),
                                 style: .timer
                            ).fontDesign(.monospaced)
                        }
                        HStack(spacing: 30) {
                            Button(intent: SimpleIntent(playerAction: .backward),
                                   label: {
                                PrevButtonLabel()
                            }).buttonStyle(.plain)
                            Button(intent: SimpleIntent(
                                playerAction: entry.songInfo.isPlaying ? .pause : .play),
                                   label: {
                                Image(systemName: entry.songInfo.isPlaying ? AppConstant.pauseIcon : AppConstant.playIcon)
                                    .font(.largeTitle)
                            }).buttonStyle(.plain)
                            Button(intent: SimpleIntent(playerAction: .forward),
                                   label: {
                                NextButtonLabel()
                            }).buttonStyle(.plain)
                        }
                    }
                }
            }
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay()
            }
        }
        .foregroundStyle(vm.simpleSongWorkshop.personalAppearance ?
                         vm.simpleSongWorkshop.fgColor : .white)
        .containerBackground(for: .widget) {
            if vm.simpleSongWorkshop.personalAppearance {
                vm.simpleSongWorkshop.bgColor
            } else {
                Color.black
                entry.songInfo.currentSongColor.opacity(0.2)
            }
        }
        .dynamicTypeSize(.medium)
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// Simplesong Widget
struct SimplesongWidget: Widget {
    let kind: String = WidgetKind.simpleSong.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            SimplesongView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.simpleSong.rawValue)
                            .description(L10n.simpleSongDesc)
    }
}

#Preview(as: .systemMedium) {
    SimplesongWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}
