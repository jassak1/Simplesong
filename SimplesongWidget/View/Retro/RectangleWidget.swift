//
//  RectangleWidget.swift
//  Simplesong
//
//  Created by Adam Jassak on 25/07/2023.
//

import SwiftUI
import WidgetKit
import MusicKit

struct RectangleView: View {
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
                GeometryReader { geo in
                    ShuffleBase(workshop: vm.wAppearance(widget: .rectangle),
                                entry: entry)
                    .frame(width: geo.size.height)
                }.padding(.leading)
            }
            OptionallyHidden(isHidden: entry.previewOnly ||
                             !vm.showAccessOverlay) {
                WidgetAccessOverlay()
            }
        }.foregroundStyle(vm.rectangleWorkshop.personalAppearance ? vm.rectangleWorkshop.fgColor : .white)
            .containerBackground(for: .widget) {
                getBg()
            }
            .dynamicTypeSize(.medium)
    }

    /// Custom SwiftUI View providing Widget background conditionally
    @ViewBuilder func getBg() -> some View {
        if vm.rectangleWorkshop.personalAppearance,
           vm.rectangleWorkshop.transparentBg {
            Image(uiImage: vm.rectangleWorkshop.image)
                .resizable()
                .scaledToFit()
        } else if vm.rectangleWorkshop.personalAppearance {
            vm.rectangleWorkshop.bgColor
        } else {
            Color.gray
            entry.songInfo.currentSongColor.opacity(0.7)
        }
    }

    init(entry: SimpleEntry) {
        self.entry = entry
        self.vm = DI.shared.widgetSharedVm
    }
}

/// Rectangle Widget
struct RectangleWidget: Widget {
    let kind: String = WidgetKind.rectangle.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: SimpleProvider()) { entry in
            RectangleView(entry: entry)
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.rectangle.rawValue)
                            .description(L10n.rectangleDesc)
    }
}

#Preview(as: .systemMedium) {
    RectangleWidget()
} timeline: {
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
    SimpleEntry(date: Date(), songInfo: SongInfo(), previewOnly: true)
}
