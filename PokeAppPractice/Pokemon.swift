//
//  Pokemon.swift
//  PokeAppPractice
//
//  Created by Younoussa Ousmane Abdou on 1/7/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokemonID: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _attack: String!
    
    var name: String {
        
        return _name
    }
    
    var pokemonID: Int {
        
        return _pokemonID
    }
    
    var type: String {
        
        if _type == nil {
            
            return ""
        }
        
        return _type
    }
    
    var height: String {
        
        if _height == nil {
            
            return ""
        }
        
        return _height
    }
    var weight: String {
        
        if _weight == nil {
            
            return ""
        }
        
        return _weight
    }
    var defense: String {
        
        if _defense == nil {
            
            return ""
        }
        
        return _defense
    }

    var attack: String {
        
        if _attack == nil {
            
            return ""
        }
        
        return _attack
    }
    
    init(name: String, pokemonID: Int) {
        
        self._name = name
        self._pokemonID = pokemonID
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        
        let pokemonURL = "\(Base_URL)\(pokemonID)/"
        
        Alamofire.request(pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 0 {
                        
                        for eachType in 1..<types.count {
                            
                            if let nextName = types[eachType]["name"] {
                                
                                self._type! += "/\(nextName.capitalized)"
                            }
                        }
                    }
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                print("types: \(self.type)")
                print("height: \(self.height)")
                print("weight: \(self.weight)")
                print("defense: \(self.defense)")
                print("attack: \(self.attack)")
            }
        }
        
        completed()
    }
}
