//
//  ContentView.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showSettings: Bool = false

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    var body: some View {
        TabView {
            PokedexView()
                .tabItem {
                    Label("Pokédex", systemImage: "pawprint")
                }
            GamesView(showSettings: $showSettings)
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
            ItemsView(showSettings: $showSettings)
                .tabItem {
                    Label("Items", systemImage: "circle.grid.3x3")
                }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
