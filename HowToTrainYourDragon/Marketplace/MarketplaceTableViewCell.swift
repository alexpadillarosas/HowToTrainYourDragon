//
//  MarketplaceTableViewCell.swift
//  HowToTrainYourDragon
//
//  Created by alex on 21/8/2025.
//

import UIKit

class MarketplaceTableViewCell: UITableViewCell {

    static let identifier = "dragonMarketplaceIdentifier"
    
    @IBOutlet weak var dragonImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var bestAtImageView: UIImageView!
    @IBOutlet weak var bestAtLabel: UILabel!
    
    @IBOutlet weak var attackProgressView: UIProgressView!
    @IBOutlet weak var defenceProgressView: UIProgressView!
    @IBOutlet weak var speedProgressView: UIProgressView!
    
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenceValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!
    
    
    func setup(dragon : Dragon){
        typeLabel.text = dragon.type
        speciesLabel.text = dragon.species
        //rawValue gives me the value assigned to the enum
        bestAtLabel.text = dragon.bestAt.rawValue.lowercased().capitalized
//        bestAtLabel.text = String(describing: dragon.bestAt).capitalized //convert an Enum into a string, then capitalize the 1st character
        
//        bestAtLabel.text = dragon.bestAt.capitalized
        
//        dragonImageView.image = UIImage(named: dragon.species)

        if !dragon.species.isEmpty && UIImage(named: dragon.species) != nil {
            dragonImageView .image = UIImage(named: dragon.species)
                
        }else{//This else is needed to reset the default image, else gets cached it and display the wrong one whenever the image cannot be found in the project
                dragonImageView.image = UIImage(named: "dragon-head")
        }
    
    
    
        switch dragon.bestAt {
        case Attribute.attack:
//        case "ATTACK":
            bestAtImageView.image = UIImage(named: "broadsword")// To change the icon
            bestAtImageView.backgroundColor = UIColor.red   // to change the background color, as the icons have a transparent background
        case Attribute.defence:
//        case "DEFENSE":
            bestAtImageView.image = UIImage(named: "griffin-shield")
            bestAtImageView.backgroundColor = UIColor.orange
        case Attribute.speed:
//        case "BOULDER":
            bestAtImageView.image = UIImage(named: "circular-sawblade")
            bestAtImageView.backgroundColor = UIColor.systemGreen
//        default:
//            bestAtImageView.image = UIImage(named: "circular-sawblade")
//            bestAtImageView.backgroundColor = UIColor.green
        }

        attackValueLabel.text = String(dragon.attack)
        defenceValueLabel.text = String(dragon.defence)
        speedValueLabel.text = String(dragon.speed)

        //initial values for all progressViews, start at 0, then we set the real value with animation
        attackProgressView.progress = 0
        defenceProgressView.progress = 0
        speedProgressView.progress = 0
        
        //Asynchronously, to not block the main thread, update each progressView to the real value after 0.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.updateProgress(for: self.attackProgressView, to: Float(dragon.attack) / 100)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateProgress(for: self.defenceProgressView, to: Float(dragon.defence) / 100)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateProgress(for: self.speedProgressView, to: Float(dragon.speed) / 100)
        }
        
    }
    
    // Updated function: Takes the specific progress view as a parameter
    func updateProgress(for progressView: UIProgressView, to value: Float) {
        UIView.animate(withDuration: 1.0) {
            progressView.setProgress(value, animated: true)
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /**
     It is called automatically by UIKit whenever the cell’s selection state changes (when a user taps a row to select/deselect it).
     
     The selected parameter tells you whether the cell is currently selected (true) or not (false).
     The animated parameter tells you whether the transition into that state should be animated.

     Why you override it:

     To customize how your cell looks when selected.
     For example, you might:
        Change the background color.
        Update text or icon appearance.
        Show or hide extra UI elements.
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
             contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
         } else {
             contentView.backgroundColor = UIColor.clear
         }
    }

}
