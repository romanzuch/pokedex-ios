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
        VStack(alignment: .center) {
            HStack {
//                Text(pokemonList[index].name).textCase(.uppercase)
                Text(viewModel.pokemonList[viewModel.index].name).textCase(.uppercase)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text("#\(viewModel.index + 1)")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            HStack {
                Spacer()
                AsyncImage(url: URL(string: self.viewModel.currentPokemon?.sprites.front_shiny ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 256, height: 256, alignment: .center)
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
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(currentPokemon?.types[0].type.getColor() ?? Color.red)
        }
        .edgesIgnoringSafeArea(.all)
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
