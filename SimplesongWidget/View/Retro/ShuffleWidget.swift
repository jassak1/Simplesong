//
//  ShuffleWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 24/07/2023.
//

import SwiftUI
import MusicKit
import WidgetKit

struct ShuffleView: View {
    let entry: SimpleEntry
    var vm: WidgetSharedVM
    var body: some View {
        ZStack {
            ShuffleBase(workshop: vm.wAppearance(widget: .shuffle),
                        entry: entry)
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay(fontSize: .callout)
            }
        }
        .foregroundStyle(vm.shuffleWorkshop.personalAppearance ? vm.shuffleWorkshop.fgColor : .white)
            .containerBackground(for: .widget) {
                getBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.shuffleWorkshop.personalAppearance,
           vm.shuffleWorkshop.transparentBg {
            Image(uiImage: vm.shuffleWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.shuffleWorkshop.personalAppearance {
            vm.shuffleWorkshop.bgColor
        } else {
            Color.gray
            entry.songInfo.currentSongColor.opacity(0.7)
        }
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        vm = DI.shared.widgetSharedVm
    }
}

/// Shuffle Widget
struct ShuffleWidget: Widget {
    let kind: String = WidgetKind.shuffle.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            ShuffleView(entry: entry)
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.shuffle.rawValue)
                            .description(L10n.shuffleDesc)
    }
}

#Preview(as: .systemSmall) {
    ShuffleWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}

/// Base SwiftUI View with Shuffle Widget appearance
struct ShuffleBase: View {
    @Binding var workshop: WidgetWorkshopProto
    var entry: SimpleEntry
    var body: some View {
        ZStack {
            Circle().stroke(lineWidth: 25)
                .foregroundStyle(workshop.personalAppearance ? workshop.detailColor : Asset.almostBlack.swiftUIColor)
                .padding(4)

            Button(intent: SimpleIntent(playerAction: .shuffle),
                   label: {
                Image(systemName: AppConstant.shuffleIcon)
                    .fontWeight(.bold)
            }).buttonStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(-5)

            Button(intent: SimpleIntent(playerAction: .backward),
                   label: {
                Image(systemName: AppConstant.prevIcon)
            }).buttonStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(-5)

            Button(intent: SimpleIntent(playerAction: .forward),
                   label: {
                Image(systemName: AppConstant.nextIcon)
            }).buttonStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(-5)

            Button(intent: SimpleIntent(
                playerAction: entry.songInfo.isPlaying ? .pause : .play),
                   label: {
                Image(systemName: entry.songInfo.isPlaying ? AppConstant.pauseIcon : AppConstant.playIcon)
                    .font(.largeTitle)
            }).buttonStyle(.plain)


            Button(intent: SimpleIntent(playerAction: .restart),
                   label: {
                Image(systemName: AppConstant.restartIcon)
                    .fontWeight(.bold)
            }).buttonStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(-5)

        }
    }
}
