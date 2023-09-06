//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 06.09.23.
//

import Foundation
import SwiftUI

class PokedexViewModel: ObservableObject {
    @Published var pokemonList: [PokemonResultsItem] = []
    @Published var index: Int = 0
    @Published var currentPokemon: Pokemon?
}

extension PokedexViewModel {
    func fetchPokemonList() {
        APIService.shared.fetchPokemonList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    let newPokemonList: [PokemonResultsItem] =  results.results
                    self.pokemonList = newPokemonList
                    let urlString: String = newPokemonList[0].url
                    APIService.shared.fetchPokemon(url: urlString) { result in
                        switch result {
                        case .success(let pokemon):
                            DispatchQueue.main.async {
                                let newPokemon: Pokemon = pokemon
                                self.currentPokemon = newPokemon
                            }
                        case .failure(let failure):
                            debugPrint("ERROR >>> \(failure)")
                        }
                    }
                case .failure(let failure):
                    debugPrint("ERROR >>> \(failure)")
                }
            }
        }
    }
    func fetchPokemonList(completion: @escaping (([PokemonResultsItem]?, Pokemon?) -> Void)) {
        APIService.shared.fetchPokemonList { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    let pokemonList: [PokemonResultsItem] =  results.results
                    let urlString: String = pokemonList[0].url
                    APIService.shared.fetchPokemon(url: urlString) { result in
                        switch result {
                        case .success(let pokemon):
                            let newPokemon: Pokemon = pokemon
                            completion(pokemonList, newPokemon)
                        case .failure(let failure):
                            debugPrint("ERROR >>> \(failure)")
                        }
                    }
                case .failure(let failure):
                    debugPrint("ERROR >>> \(failure)")
                }
            }
        }
    }
    func next() {
        if (self.index + 1) % 20 == 0 && (self.index + 1) <= self.pokemonList.count {
            APIService.shared.fetchPokemonList { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let results):
                        let newPokemonList: [PokemonResultsItem] =  results.results
                        self.pokemonList.append(contentsOf: newPokemonList)
                        let urlString: String = newPokemonList[0].url
                        APIService.shared.fetchPokemon(url: urlString) { result in
                            switch result {
                            case .success(let pokemon):
                                DispatchQueue.main.async {
                                    let newPokemon: Pokemon = pokemon
                                    self.index += 1
                                    self.currentPokemon = newPokemon
                                }
                            case .failure(let failure):
                                debugPrint("ERROR >>> \(failure)")
                            }
                        }
                    case .failure(let failure):
                        debugPrint("ERROR >>> \(failure)")
                    }
                }
            }
        } else if (self.index + 1) <= self.pokemonList.count {
            self.index += 1
            let urlString = self.pokemonList[self.index].url
            APIService.shared.fetchPokemon(url: urlString) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        let newPokemon: Pokemon = response
                        self.currentPokemon = newPokemon
                    }
                case .failure(let failure):
                    debugPrint("ERROR >>> \(failure)")
                }
            }
        }
    }
    func previous() {
        if self.index > 0 {
            self.index -= 1
            let urlString = self.pokemonList[self.index].url
            APIService.shared.fetchPokemon(url: urlString) { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        let newPokemon: Pokemon = response
                        self.currentPokemon = newPokemon
                    }
                case .failure(let failure):
                    debugPrint("ERROR >>> \(failure)")
                }
            }
        }
    }
}
