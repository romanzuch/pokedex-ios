//
//  GamesView.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import SwiftUI

struct GamesView: View {
    @Binding var showSettings: Bool
    
    init(showSettings: Binding<Bool>) {
        self._showSettings = showSettings
    }
    
    var body: some View {
        NavigationView {
            Text("Games")
                .navigationTitle("Games")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SettingsToolbarButton(showSettings: self._showSettings)
                    }
                }
        }
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView(showSettings: .constant(false))
    }
}
