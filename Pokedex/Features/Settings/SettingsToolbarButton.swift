//
//  SettingsToolbarButton.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import SwiftUI

struct SettingsToolbarButton: View {
    @Binding var showSettings: Bool
    
    init(showSettings: Binding<Bool>) {
        self._showSettings = showSettings
    }
    
    var body: some View {
        Button {
            self.showSettings = true
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

struct SettingsToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsToolbarButton(showSettings: .constant(false))
    }
}
