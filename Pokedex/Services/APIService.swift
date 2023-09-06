//
//  APIService.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import Foundation
import Combine

class APIService {
    static let shared: APIService = APIService()
    private let pokemonBaseUrl: URL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private var cancellables = Set<AnyCancellable>()
    private var nextUrl: URL?
    private var previousUrl: URL?
}

extension APIService {
    func fetchPokemonList(handler: @escaping ((Result<PokemonResults, Error>) -> Void)) {
        let url = self.nextUrl != nil ? self.nextUrl! : self.pokemonBaseUrl
        debugPrint("URL >>> \(url)")
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PokemonResults.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { result in
                if let nextUrl = result.next {
                    guard let url = URL(string: nextUrl) else { return }
                    self.nextUrl = url
                }
                if let previousUrl = result.previous {
                    guard let url = URL(string: previousUrl) else { return }
                    self.previousUrl = url
                }
                handler(.success(result))
            }
            .store(in: &cancellables)
    }
    func fetchPokemon(url: String, handler: @escaping ((Result<Pokemon, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            handler(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in }) { result in
                handler(.success(result))
            }
            .store(in: &cancellables)
    }
}
