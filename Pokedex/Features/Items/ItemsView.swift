//
//  ItemsView.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import SwiftUI

struct ItemsView: View {
    @Binding var showSettings: Bool
    
    init(showSettings: Binding<Bool>) {
        self._showSettings = showSettings
    }
    
    var body: some View {
        NavigationView {
            Text("Items")
                .navigationTitle("Items")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SettingsToolbarButton(showSettings: self._showSettings)
                    }
                }
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(showSettings: .constant(false))
    }
}
