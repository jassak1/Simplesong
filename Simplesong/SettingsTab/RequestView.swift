//
//  RequestView.swift
//  Simplesong
//
//  Created by Adam Jassak on 06/08/2023.
//

import SwiftUI

struct RequestView: View {
    @Environment(\.scenePhase) var scenePhase
    var vm: SettingsVM
    var body: some View {
        ZStack {
            VStack {
                monoText(L10n.requestInfo)
                Button(action: {
                    vm.musicService.requestAuthorization()
                }, label: {
                    monoText(L10n.requestBtn)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Asset.accentColor.swiftUIColor)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .foregroundStyle(.black)
                }).padding(20)
                HStack {
                    monoText(L10n.requestStatus)
                        .fontWeight(.black)
                    monoText("\(vm.accessDescription)")
                        .foregroundStyle(vm.accessFgColor)

                }
                Spacer()
            }.padding()
                .onChange(of: scenePhase) {
                    // ScenePhase change will trigger View Reload once the System pop-up is presented/dismissed
                }
        }.navigationTitle(L10n.requestTitle)
            .dynamicTypeSize(.medium)
    }

    init() {
        vm = DI.shared.settingsVm
    }
}

#Preview {
    RequestView()
}
