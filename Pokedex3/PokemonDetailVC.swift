//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Gagandeep Singh on 4/3/17.
//  Copyright © 2017 Gagandeep Singh. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    
    @IBOutlet weak var nameLbl: UILabel!
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalized

        
        
    }

  
   
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }

}
