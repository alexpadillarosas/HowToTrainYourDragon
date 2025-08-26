//
//  MyDragonDetailsTableViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 26/8/2025.
//

import UIKit

class MyDragonDetailsTableViewController: UITableViewController {

    var dragon : MyDragon!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dragonImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var drawsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenceValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!
    @IBOutlet weak var bestAtLabel: UILabel!
    @IBOutlet weak var bestAtImageView: UIImageView!
    
    @IBOutlet weak var attackProgressView: UIProgressView!
    @IBOutlet weak var defenceProgressView: UIProgressView!
    @IBOutlet weak var SpeedProgressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        nameTextField.text = dragon.name
        
        //currentDragon.bloodline = "STOKER-TERRIBLE TERROR"
        //TODO: Type, species, bestAt will be replaced by querying the general dragon collection and take the information from there.
        //bestAtLabel.text =
        typeLabel.text = dragon.bloodline.components(separatedBy: "-").first ?? ""
        let species = dragon.bloodline.components(separatedBy: "-").last ?? ""
        speciesLabel.text = species
        //setBest At from the dragon collection

        
        dragonImageView.image = UIImage(named: species)
        
        
        winsLabel.text = String(dragon.wins)
        drawsLabel.text = String(dragon.draws)
        lossesLabel.text = String(dragon.losses)
        
        attackValueLabel.text = String(dragon.attack)
        defenceValueLabel.text = String(dragon.defence)
        speedValueLabel.text = String(dragon.speed)
        
        attackProgressView.progress = Float(dragon.attack) / 100
        defenceProgressView.progress = Float(dragon.defence) / 100
        SpeedProgressView.progress = Float(dragon.speed) / 100
        
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
