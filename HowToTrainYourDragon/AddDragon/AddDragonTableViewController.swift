//
//  AddDragonTableViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/11/2025.
//

import UIKit
import FirebaseFirestore

class AddDragonTableViewController: UITableViewController {

    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var bestAtTextField: UITextField!
    @IBOutlet weak var attackTextField: UITextField!
    @IBOutlet weak var defenceTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var totalInvalidComponents : Int = 0
        
        if typeTextField.text.isBlank {
            typeTextField.showInvalidBorder()
            totalInvalidComponents = totalInvalidComponents + 1
        }else{
            typeTextField.removeInvalidBorder()
        }
        
        
        if speciesTextField.text.isBlank {
            speciesTextField.showInvalidBorder()
            totalInvalidComponents = totalInvalidComponents + 1
        }else{
            speciesTextField.removeInvalidBorder()
        }
        
        if bestAtTextField.text.isBlank {
            bestAtTextField.showInvalidBorder()
            totalInvalidComponents = totalInvalidComponents + 1
        }else{
            bestAtTextField.removeInvalidBorder()
        }
        
        if attackTextField.text.isBlank {
            attackTextField.showInvalidBorder()
            totalInvalidComponents = totalInvalidComponents + 1
        }else{
            attackTextField.removeInvalidBorder()
        }
        
        if defenceTextField.text.isBlank {
            defenceTextField.showInvalidBorder()
            totalInvalidComponents = totalInvalidComponents + 1
        }else{
            defenceTextField.removeInvalidBorder()
        }
        
        if speedTextField.text.isBlank {
            speedTextField.showInvalidBorder()
            totalInvalidComponents = totalInvalidComponents + 1
        }else{
            speedTextField.removeInvalidBorder()
        }
        
        
        if totalInvalidComponents > 0 {
            return false
        }else{
            return true
        }
    }
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let pk = "\(typeTextField.text ?? "")-\(speciesTextField.text ?? "")"
        var best : Attribute;
        switch bestAtTextField.text {
        case Attribute.attack.rawValue:
            best = Attribute.attack
        case Attribute.defence.rawValue:
            best = Attribute.defence
        case Attribute.speed.rawValue:
            best = Attribute.speed
        default:
            best = Attribute.speed
        }
        
        
        let dragon = Dragon(id: pk,
                            type: typeTextField.text!,
                            species: speciesTextField.text!,
                            bestAt: best,
                            attack: Int(attackTextField.text!)!,
                            defence: Int(defenceTextField.text!)!,
                            speed: Int(speedTextField.text!)!)
        
        let db = DragonsRepository.sharedDragonsRepository
        Task{
            do{
                try await db.addDragon(dragon: dragon)
            }catch{
                print("Error: \(error)")
            }
        }
    }
    

}
