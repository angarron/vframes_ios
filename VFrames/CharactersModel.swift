//
//  CharactersModel.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class CharactersModel {
    
    var characters: [CharacterID: SFCharacter]
    
    init(characters: [CharacterID:SFCharacter]) {
        self.characters = characters
    }
    
    func getCharacter(characterId:CharacterID) -> SFCharacter {
        return characters[characterId]!
    }
    
    func toString() -> String {
        var stringRepresentation = String()
        for (characterId, sfCharacter) in characters {
            stringRepresentation += String(characterId) + "\n\(sfCharacter.getStringRepresentation())"
        }
        return stringRepresentation
    }
}