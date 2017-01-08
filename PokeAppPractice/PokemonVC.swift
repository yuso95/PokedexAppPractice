//
//  PokemonVC.swift
//  PokeAppPractice
//
//  Created by Younoussa Ousmane Abdou on 1/7/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class PokemonVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // Var/Let/CP
    
    private var pokemons = [Pokemon]()
    private var filteredPokemons = [Pokemon]()
    private var inSearchMode = false
    // Outlets
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // Actions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Outlets setup
        
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        collectionView.delegate = self
        collectionView.dataSource = self
        
        parsingCSVFile()
    }
    
    // Parsing the CSV files
    
    func parsingCSVFile() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            
            let csv = try CSV(contentsOfURL: path!)
            
            let rows = csv.rows
            
            for row in rows {
                
                let name = String(row["identifier"]!)!
                let id = Int(row["id"]!)!
                
                let pokemon = Pokemon(name: name, pokemonID: id)
                
                pokemons.append(pokemon)
                
            }
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    // UICollectionView Functions
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredPokemons.count
        } else {
            
            
            return pokemons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? PokemonCell {
            
            let eachPokemon = pokemons[indexPath.row]
            
            let filteredPokemon: Pokemon!
            
            if inSearchMode {
                
                filteredPokemon = filteredPokemons[indexPath.row]
                cell.configureCell(pokemon: filteredPokemon)
            } else {
                
                cell.configureCell(pokemon: eachPokemon)
            }
            
            return cell
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPokemon = pokemons[indexPath.row]
        
        performSegue(withIdentifier: "goToPokemonDetailVC", sender: selectedPokemon)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToPokemonDetailVC" {
            if let destination = segue.destination as? PokemonDetailVC {
                
                if let pokemon = sender as? Pokemon {
                    
                    destination.pokemon = pokemon
                }
            }
        }
    }
    
    // UISearchBar Functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text?.lowercased()
            
            filteredPokemons = pokemons.filter({ (filteredName) -> Bool in
                
                return filteredName.name.range(of: lower!) != nil
            })
            
            collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
}

