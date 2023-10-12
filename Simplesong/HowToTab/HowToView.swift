//
//  HowToView.swift
//  Simplesong
//
//  Created by Adam Jassak on 14/07/2023.
//

import SwiftUI

struct HowToView: View {
    var vm: HowToVM
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    LazyVGrid(columns: [GridItem(),
                                        GridItem()]) {
                        ForEach(HowToSelection.allCases, id: \.self) { item in
                            howToBtn(selectedItem: item)
                        }
                    }.padding(.bottom, 20)
                    Spacer()
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 10) {
                            monoText(vm.helpHeader)
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom)
                            ForEach(Array(zip(vm.helpNotes.indices, vm.helpNotes)), id: \.0) { index, element in
                                Label(title: {
                                    monoText(element)
                                }, icon: {
                                    Image(systemName: "\(index+1)\(AppConstant.circleIcon)")
                                        .foregroundStyle(.green)
                                        .imageScale(.large)
                                })
                                .labelStyle(LabelCenterStyle())
                            }
                        }
                    }.scrollIndicators(.hidden)
                }.padding(.horizontal)
            }.navigationTitle(L10n.howToTitle)
                .dynamicTypeSize(.medium)
        }
    }

    /// Custom SwiftUI View providing How To Button
    func howToBtn(selectedItem: HowToSelection) -> some View {
        Button(action: {
            withAnimation(.snappy) {
                vm.onHowToBtn(selectedItem: selectedItem)
            }
        }, label: {
            monoText(selectedItem.rawValue)
                .font(.headline)
        })
        .padding(10)
        .frame(width: 150)
        .background(vm.getHowToBg(selectedBtn: selectedItem))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundStyle(.black)
    }

    init() {
        self.vm = DI.shared.howToVm
    }
}

#Preview {
    HowToView()
}
