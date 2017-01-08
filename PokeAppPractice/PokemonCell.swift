//
//  PokemonCell.swift
//  PokeAppPractice
//
//  Created by Younoussa Ousmane Abdou on 1/7/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var labelCell: UILabel!
    
    func configureCell(pokemon: Pokemon) {
        
        imageCell.image = UIImage(named: "\(pokemon.pokemonID)")
        labelCell.text = pokemon.name
    }
}
