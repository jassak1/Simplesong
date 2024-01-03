//
//  WidgampWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 25/07/2023.
//

import SwiftUI
import WidgetKit
import MusicKit

struct WidgampView: View {
    let entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 2)
                        .frame(height: 10)
                        .foregroundStyle(
                            vm.widgamptWorkshop.personalAppearance ?
                            vm.widgamptWorkshop.detailColor :
                            .orange.opacity(0.7)
                        )
                    monoText(AppConstant.widgamp)
                        .fontWeight(.bold)
                    RoundedRectangle(cornerRadius: 2)
                        .frame(height: 10)
                        .foregroundStyle(
                            vm.widgamptWorkshop.personalAppearance ?
                            vm.widgamptWorkshop.detailColor :
                            .orange.opacity(0.7)
                        )
                }.padding(.top, -5)
                    .padding(.horizontal, 1)
                GeometryReader { geo in
                    HStack {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: geo.size.width/3,
                                   height: geo.size.height)
                            .foregroundStyle(.black)
                            .overlay(
                                OptionallyHidden(isHidden: !entry.songInfo.isPlaying) {
                                    Text(Date()
                                        .addingTimeInterval(-SystemMusicPlayer.shared.playbackTime),
                                         style: .timer
                                    ).fontDesign(.monospaced)
                                        .padding(.leading)
                                }
                                    .foregroundStyle(.green.opacity(0.8))
                                    .font(.title)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.gray)
                                )
                        VStack(alignment: .trailing, spacing: 15) {
                            monoText(L10n.song)
                                    .font(.caption)
                            monoText(L10n.author)
                                    .font(.caption)
                        }.frame(maxHeight: .infinity, alignment: .center)
                        VStack(spacing: 10) {
                            rectangleLabel(text: entry.songInfo.currentSongTitle)
                            rectangleLabel(text: entry.songInfo.currentSongAuthor)
                        }.frame(maxHeight: .infinity, alignment: .center)
                    }
                }.padding(.bottom, 10)
                buttonStack
            }
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay()
            }
        }.foregroundStyle(vm.widgamptWorkshop.personalAppearance ?
                          vm.widgamptWorkshop.fgColor : .white)
        .background(getContainerBg())
            .containerBackground(for: .widget) {
                getContainerBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget's background conditionally
    @ViewBuilder func getContainerBg() -> some View {
        if vm.widgamptWorkshop.personalAppearance {
            vm.widgamptWorkshop.bgColor
        } else {
            bgDefaultColor
        }
    }

    /// Computed property providing default background Color
    var bgDefaultColor: some View {
        ZStack {
            Color.white
            Color.black.opacity(0.9)
        }
    }

    /// Method returning SwiftUI View of rectangle with Text overlay
    func rectangleLabel(text: String) -> some View {
        RoundedRectangle(cornerRadius: 2)
        .foregroundStyle(.black)
        .frame(height: 20)
        .overlay(
            Text(text)
                .padding(.leading, 5)
                .font(.caption)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .foregroundStyle(.green.opacity(0.8))
        )
    }

    /// Computed property returning SwiftUI Button stack View
    var buttonStack: some View {
        HStack(spacing: 20) {
            Button(intent: SimpleIntent(playerAction: .backward),
                   label: {
                PrevButtonLabel()
            }).buttonStyle(.plain)

            Button(intent: SimpleIntent(playerAction: .play),
                   label: {
                Image(systemName: AppConstant.playIcon)
            }).buttonStyle(.plain)

            Button(intent: SimpleIntent(playerAction: .pause),
                   label: {
                Image(systemName: AppConstant.pauseIcon)
            }).buttonStyle(.plain)

            Button(intent: SimpleIntent(playerAction: .forward),
                   label: {
                NextButtonLabel()
            }).buttonStyle(.plain)

            Spacer()
            HStack {
                Button(intent: SimpleIntent(playerAction: .shuffle),
                       label: {
                    Image(systemName: AppConstant.shuffleIcon)
                        .padding(2)
                        .foregroundStyle(vm.widgamptWorkshop.personalAppearance ?
                                         vm.widgamptWorkshop.bgColor : .black)
                        .background(vm.widgamptWorkshop.personalAppearance ? vm.widgamptWorkshop.fgColor : .white)
                        .clipShape(.rect)
                }).buttonStyle(.plain)

                Button(intent: SimpleIntent(playerAction: .restart),
                       label: {
                    Image(systemName: AppConstant.restartIcon)
                        .padding(3)
                        .foregroundStyle(vm.widgamptWorkshop.personalAppearance ?
                                         vm.widgamptWorkshop.bgColor : .black)
                        .background(vm.widgamptWorkshop.personalAppearance ? vm.widgamptWorkshop.fgColor : .white)
                        .clipShape(.rect)
                }).buttonStyle(.plain)
            }.padding(.leading)
        }
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        self.vm = DI.shared.widgetSharedVm
    }
}

/// Widgamp Widget
struct WidgampWidget: Widget {
    let kind: String = WidgetKind.widgamp.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            WidgampView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.widgamp.rawValue)
                            .description(L10n.widgampDesc)
    }
}

#Preview(as: .systemMedium) {
    WidgampWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}
