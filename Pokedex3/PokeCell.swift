//
//  PokeCell.swift
//  Pokedex3
//
//  Created by Gagandeep Singh on 3/23/17.
//  Copyright © 2017 Gagandeep Singh. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //var pokemon : Pokemon!
    
    
    //For rounding the UICollectionViewCell
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func congifureCell(_ pokemon: Pokemon) {
        
       // self.pokemon = pokemon
        //self.nameLbl.text = self.pokemon.name
        //self.thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        self.nameLbl.text = pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
        
    }
}
