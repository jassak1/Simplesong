//
//  TransparentBgView.swift
//  Simplesong
//
//  Created by Adam Jassak on 28/07/2023.
//

import SwiftUI
import PhotosUI
import Translucent

struct TransparentBgView: View {
    @Bindable var widgetVm: WidgetSharedVM
    var selectedWidget: WidgetKind
    var body: some View {
        VStack {
            PhotosPicker(selection: $widgetVm.photosItem) {
                Label(
                    title: {
                        monoText(L10n.pickBgImage)
                            .fontWeight(.bold)
                    },
                    icon: {
                        Image(systemName: AppConstant.galleryIcon)
                    }
                )
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            widgetVm.photosImage
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(.gray)
                )
                .overlay(
                    OptionallyHidden(isHidden: FileManager.getImage(fileName: .bgImage) == nil) {
                        widgetOverlay()
                    }
                )
        }.navigationTitle(L10n.transparentWorkshopTitle)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .dynamicTypeSize(.medium)
    }


    /// Custom SwiftUI View providing Widget overlay content conditionally
    @ViewBuilder func widgetOverlay() -> some View {
        if WidgetKind.mediumWidgets.contains(selectedWidget) {
            mediumOverlay
        } else {
            smallOverlay
        }
    }

    /// Computed property providing Medium Widget Overlay layout
    var mediumOverlay: some View {
        VStack {
            mediumWidgetOverlay(position: .mediumTop)
                .padding(.top, 50)
            Spacer()
            mediumWidgetOverlay(position: .mediumCenter)
            Spacer()
            mediumWidgetOverlay(position: .mediumBottom)
                .padding(.bottom, 150)
        }.padding()
    }

    /// Computed property providing Small Widget Overlay layout
    var smallOverlay: some View {
        VStack {
            HStack {
                smallWidgetOverlay(position: .smallTopLeft)
                Spacer()
                smallWidgetOverlay(position: .smallTopRight)
            }.padding(.top, 50)
            Spacer()
            HStack {
                smallWidgetOverlay(position: .smallCenterLeft)
                Spacer()
                smallWidgetOverlay(position: .smallCenterRight)
            }
            Spacer()
            HStack {
                smallWidgetOverlay(position: .smallBottomLeft)
                Spacer()
                smallWidgetOverlay(position: .smallBottomRight)
            }.padding(.bottom, 150)
        }.padding()
    }

    /// Custom SwiftUI View providing Medium Widget Overlay
    func mediumWidgetOverlay(position: WidgetCropPosition) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.black.opacity(0.7))
            .frame(width: 200, height: 100)
            .overlay(overlayLabel(isSelected: position.rawValue == widgetVm.wAppearance(widget: selectedWidget).imagePosition.wrappedValue))
            .onTapGesture {
                widgetVm.wAppearance(widget: selectedWidget).imagePosition.wrappedValue = position.rawValue
                widgetVm.wAppearance(widget: selectedWidget).image.wrappedValue = Wallpaper(FileManager.getImage(fileName: .bgImage) ?? UIImage()).widgetBackground(for: position) ?? UIImage()
            }
    }

    /// Custom SwiftUI View providing Small Widget Overlay
    func smallWidgetOverlay(position: WidgetCropPosition) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.black.opacity(0.7))
            .frame(width: 100, height: 100)
            .overlay(overlayLabel(isSelected: position.rawValue == widgetVm.wAppearance(widget: selectedWidget).imagePosition.wrappedValue))
            .onTapGesture {
                widgetVm.wAppearance(widget: selectedWidget).imagePosition.wrappedValue = position.rawValue
                widgetVm.wAppearance(widget: selectedWidget).image.wrappedValue = Wallpaper(FileManager.getImage(fileName: .bgImage) ?? UIImage()).widgetBackground(for: position) ?? UIImage()
            }
    }

    /// Custom SwiftUI View providing conditional Widget Overlay
    @ViewBuilder func overlayLabel(isSelected: Bool) -> some View {
        if isSelected {
            Image(systemName: AppConstant.checkmarkIcon)
                .imageScale(.large)
                .font(.largeTitle)
                .foregroundStyle(Asset.accentColor.swiftUIColor)
        } else {
            monoText(L10n.widgetPositionSelect)
                .multilineTextAlignment(.center)
                .font(.callout)
                .foregroundStyle(.white)
        }
    }

    init(selectedWidget: WidgetKind) {
        self.widgetVm = DI.shared.widgetSharedVm
        self.selectedWidget = selectedWidget
    }
}

#Preview {
    TransparentBgView(selectedWidget: .simpleSong)
}
