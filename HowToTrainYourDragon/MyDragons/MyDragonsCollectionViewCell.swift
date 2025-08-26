//
//  MyDragonsCollectionViewCell.swift
//  HowToTrainYourDragon
//
//  Created by alex on 22/8/2025.
//

import UIKit

class MyDragonsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "myDragonIdentifier"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dragonImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var lossLabel: UILabel!
    
    func setup(dragonName: String, type: String, species: String, win : Int, draw: Int, loss : Int){
        
        nameLabel.text = dragonName
        typeLabel.text = type
        speciesLabel.text = species
        winLabel.text = String(win)
        drawLabel.text = String(draw)
        lossLabel.text = String(loss)
        
        dragonImageView.image = UIImage(named: species)
        
    }
}
