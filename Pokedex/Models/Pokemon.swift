//
//  Pokemon.swift
//  Pokedex
//
//  Created by Roman Zuchowski on 05.09.23.
//

import Foundation
import SwiftUI

struct PokemonResults: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PokemonResultsItem]
}

struct PokemonResultsItem: Codable {
    var name: String
    var url: String
}

struct Pokemon: Codable {
    var abilities: [PokemonAbility]
    var forms: [PokemonForm]
    var moves: [PokemonMove]
    var sprites: PokemonSprite
    var stats: [PokemonStat]
    var types: [PokemonType]
}

struct PokemonAbility: Codable {
    var ability: PokemonAbilityInfo
    var is_hidden: Bool
    var slot: Int
}

struct PokemonAbilityInfo: Codable {
    var name: String
    var url: String
}

struct PokemonForm: Codable {
    var name: String
    var url: String
}

struct PokemonMove: Codable {
    var move: PokemonMoveInfo
}

struct PokemonMoveInfo: Codable {
    var name: String
    var url: String
}

struct PokemonSprite: Codable {
    var back_default: String
    var back_shiny: String
    var front_default: String
    var front_shiny: String
}

struct PokemonStat: Codable {
    var base_stat: Int
    var effort: Int
    var stat: PokemonStatInfo
}

extension PokemonStat: Hashable {
    static func == (lhs: PokemonStat, rhs: PokemonStat) -> Bool {
        return lhs.base_stat == rhs.base_stat &&
               lhs.effort == rhs.effort &&
               lhs.stat == rhs.stat
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(base_stat)
        hasher.combine(effort)
        hasher.combine(stat)
    }
}

struct PokemonStatInfo: Codable {
    var name: String
    var url: String
}

extension PokemonStatInfo: Hashable {
    static func == (lhs: PokemonStatInfo, rhs: PokemonStatInfo) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}

struct PokemonType: Codable {
    var slot: Int
    var type: PokemonTypeInfo
}

struct PokemonTypeInfo: Codable {
    var name: String
    var url: String
}

extension PokemonTypeInfo {
    func getColor() -> Color {
        switch name {
        case "grass":
            return Color.green
        default:
            return Color.gray
        }
    }
}
