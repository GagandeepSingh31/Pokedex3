//
//  ViewController.swift
//  Pokedex3
//
//  Created by Gagandeep Singh on 3/22/17.
//  Copyright © 2017 Gagandeep Singh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UISearchBarDelegate {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()
    
    var pokemon = [Pokemon]()
    var musicPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        
        searchBar.returnKeyType = UIReturnKeyType.done
     //let charmender = Pokemon(name: "Charmender", pokedexId: 4)
        
        parsePokemonCSV()
        initAudio()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text  == nil || searchBar.text == "" {
           inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        }else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil })
            collectionView.reloadData()
        }
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
        }catch {
            
        }
            
        
        
    }
    
    
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        }catch  let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            //let poke = pokemon[indexPath.row]
            let poke: Pokemon!
            
            if inSearchMode{
                poke = filteredPokemon[indexPath.row]
            }else {
                poke = pokemon[indexPath.row]
            }
            cell.congifureCell(poke)
            
            return cell
        }else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke : Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        }else {
            poke = pokemon[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC" {
            if let destination = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    destination.pokemon = poke
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }

   

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            sender.alpha = 0.2
        }else {
            musicPlayer.play()
            sender.alpha = 1.0
        }

    }
   
}

