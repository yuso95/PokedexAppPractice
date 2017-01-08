//
//  PokemonDetailVC.swift
//  PokeAppPractice
//
//  Created by Younoussa Ousmane Abdou on 1/8/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    // Variables/Constants/Computed Properties
    
    var pokemon: Pokemon!
    // Outlets
    
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var mainIMG: UIImageView!
    @IBOutlet private weak var descriptionLBL: UILabel!
    @IBOutlet private weak var typeLBL: UILabel!
    @IBOutlet private weak var heightLBL: UILabel!
    @IBOutlet private weak var weightLBL: UILabel!
    @IBOutlet private weak var defenseLBL: UILabel!
    @IBOutlet private weak var pokedexIDLBL: UILabel!
    @IBOutlet private weak var attackLBL: UILabel!
    @IBOutlet private weak var evolutionLBL: UILabel!
    @IBOutlet private weak var currentEvolutionIMG: UIImageView!
    @IBOutlet private weak var nextEvolutionIMG: UIImageView!
    // Actions

    @IBAction func backBTNPressed(sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemon.downloadPokemonDetail {
            
            updateUI()
        }
    }
    
    private func updateUI() {
        
        topLabel.text = pokemon.name
        pokedexIDLBL.text = "\(pokemon.pokemonID)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
