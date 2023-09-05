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

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    var body: some View {
        TabView {
            Text("Pokémon")
                .tabItem {
                    Label("Pokédex", systemImage: "pawprint")
                }
            Text("Games")
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
            Text("Items")
                .tabItem {
                    Label("Items", systemImage: "circle.grid.3x3")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
