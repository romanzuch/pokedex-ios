//
//  PokedexView.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import SwiftUI

struct PokedexView: View {
    @StateObject private var viewModel: PokedexViewModel = PokedexViewModel()
    @State private var pokemonList: [PokemonResultsItem] = []
    @State private var index: Int = 0
    @State private var currentPokemon: Pokemon?
    
    @ViewBuilder
    var body: some View {
        if !self.viewModel.pokemonList.isEmpty {
            cards
        } else {
            ProgressView().progressViewStyle(.circular)
            .onAppear {
                viewModel.fetchPokemonList()
//                viewModel.fetchPokemonList { (list, pokemon) in
//                    if let newList = list, let newPokemon = pokemon {
//                        DispatchQueue.main.async {
//                            self.pokemonList = newList
//                            self.currentPokemon = newPokemon
//                        }
//                    }
//                }
            }
        }
    }
    
    var cards: some View {
        ZStack {
            // background
            viewModel.currentPokemon?.types[0].type.getColor().ignoresSafeArea() ?? Color.gray.ignoresSafeArea()
            // foreground
            VStack(alignment: .center) {
                HStack {
                    Text(viewModel.pokemonList[viewModel.index].name).textCase(.uppercase)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text("#\(viewModel.index + 1)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.top, 48)
                
                Spacer()
                
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: self.viewModel.currentPokemon?.sprites.front_shiny ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 512, height: 512, alignment: .center)
                    } placeholder: {
                        ProgressView().progressViewStyle(.circular)
                    }
                    Spacer()
                }
                .padding(-80)
                .zIndex(-1)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Stats").textCase(.uppercase)
                        .font(.title3)
                        .fontWeight(.semibold)
                    stats
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button {
                        viewModel.previous()
                    } label: {
                        Image(systemName: "chevron.up.circle")
                            .font(.largeTitle)
                    }
                    .buttonStyle(.plain)
                    Button {
                        viewModel.next()
                    } label: {
                        Image(systemName: "chevron.down.circle")
                            .font(.largeTitle)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    var stats: some View {
        if let currentPokemon = self.viewModel.currentPokemon {
            ForEach(currentPokemon.stats, id: \.self) { stat in
                HStack {
                    Text(stat.stat.name).textCase(.uppercase)
                    Spacer()
                    Text("\(stat.base_stat)")
                }
            }
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
