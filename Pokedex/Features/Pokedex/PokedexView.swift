//
//  PokedexView.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import SwiftUI

struct PokedexView: View {
    @Binding var showSettings: Bool
    
    init(showSettings: Binding<Bool>) {
        self._showSettings = showSettings
    }
    
    var body: some View {
        NavigationView {
            Text("Pokedex")
                .navigationTitle("Pokédex")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SettingsToolbarButton(showSettings: self._showSettings)
                    }
                }
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView(showSettings: .constant(false))
    }
}
