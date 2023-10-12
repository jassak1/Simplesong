//
//  HomeView.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

struct HomeView: View {
    @Bindable var viewModel: HomeVM
    var body: some View {
        // MARK: - HomeView
        NavigationStack {
            ZStack {
                VStack {
                    categoryTitleView
                    HStack {
                        ForEach(WidgetCategory.allCases, id: \.self) { item in
                            categoryButtonView(category: item)
                        }
                    }.padding(.horizontal, 20)
                        .padding(.bottom, 50)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.allWidgets, id: \.self) { item in
                                cardView(widgetKind: item)
                            }
                        }.scrollTargetLayout()
                    }.scrollTargetBehavior(.viewAligned)
                        .safeAreaPadding(.horizontal, 50)
                        .id(viewModel.scrollId)
                }
            }
            .navigationTitle(L10n.home)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.showModal = true
                    },
                           label: {
                        Image(systemName: AppConstant.cartIcon)
                    })
                }
            }
            .fullScreenCover(isPresented: $viewModel.showSheet) {
                viewModel.router.showWorkshopView()
            }
            .sheet(isPresented: $viewModel.showModal) {
                viewModel.router.showIapView()
            }
            .dynamicTypeSize(.medium)
        }
    }

    // MARK: - Helper sub Views
    /// Custom SwiftUI Category Button View
    func categoryButtonView(category: WidgetCategory) -> some View {
        Button(action: {
            withAnimation(.linear) {
                viewModel.categoryButtonAction(category: category)
            }
        }, label: {
            monoText(category.rawValue)
                .frame(width: 120)
                .fontWeight(.bold)
        })
        .padding()
        .background(viewModel.getCategoryBtnBgColor(selectedItem: category))
        .foregroundStyle(viewModel.getCategoryBtnFgColor(selectedItem: category))
        .clipShape(.capsule)
        .frame(maxWidth: .infinity)
    }

    /// Custom SwiftUI Card View
    func cardView(widgetKind: WidgetKind) -> some View {
        Rectangle()
            .foregroundStyle(.black)
            .overlay {
                VStack {
                    monoText(widgetKind.rawValue)
                        .padding()
                        .font(.title)
                        .fontWeight(.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    Image(widgetKind.rawValue)
                        .widgetBorder(for: widgetKind)
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .padding()
                        .foregroundStyle(Asset.darkGrey.swiftUIColor)
                        .frame(height: 80)
                        .overlay {
                            Button(action: {
                                withAnimation(.spring){
                                    viewModel.onWorkshopBtn(widget: widgetKind)
                                }
                            }, label: {
                                Label(
                                    title: {
                                        monoText(L10n.btnEditWidget) },
                                    icon: {
                                        Image(systemName: AppConstant.pencilIcon) }
                                )
                            }).foregroundStyle(Asset.accentColor.swiftUIColor)
                                .fontWeight(.bold)
                        }
                }

            }
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Asset.darkGrey.swiftUIColor, lineWidth: 5)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 250)
            .padding(.bottom, 20)
    }

    /// Custom SwiftUI Category Title View
    var categoryTitleView: some View {
        monoText(L10n.widgetCategory)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .font(.title3)
            .fontWeight(.bold)
    }

    // MARK: - Initialiser
    init() {
        viewModel = DI.shared.homeVm
    }
}

#Preview {
    HomeView()
}
