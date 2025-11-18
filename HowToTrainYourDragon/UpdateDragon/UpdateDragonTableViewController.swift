//
//  UpdateDragonTableViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/11/2025.
//

import UIKit

// MARK: we made the TableViewController to extend UIPickerViewDataSource and UIPickerViewDelegate as this view controller will manipulate a PickerView to select the BestAt Attribute
class UpdateDragonTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    
    //variable that receives the dragon to edit, via segue
    var dragon : Dragon!
    
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var attackTextField: UITextField!
    @IBOutlet weak var defenceTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    
    @IBOutlet weak var bestAtPickerView: UIPickerView!
    
    let bestAtValues = ["SPEED", "ATTACK", "DEFENCE"]
    
    var bestAtSelecteValue: String!
    
    private var headerLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print("\(dragon.type)")
        
        typeTextField.text = dragon.type
        speciesTextField.text = dragon.species
        attackTextField.text = String(dragon.attack)
        defenceTextField.text = String(dragon.defence)
        speedTextField.text = String(dragon.speed)
        
        bestAtPickerView.dataSource = self
        bestAtPickerView.delegate = self
        if let index = bestAtValues.firstIndex(of: dragon.bestAt.rawValue) {
            bestAtPickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
  
        
    }

    // MARK: configure the # columns in the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    // MARK: configure the # rows to display in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bestAtValues.count
    }
    // MARK: Set the Value to the picker view elements in each row by using the array bestAtValues values
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        bestAtValues[row]
    }
    // MARK: set the selected item (when the user click on it) to a String variable called bestAtSelectedValue
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bestAtSelecteValue = bestAtValues[row]
    }
    
    // MARK: This method stops the navigation is false is return, it is used to do validations. This method gets called before prepareForSegue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var totalInvalidComponents : Int = 0
        
        
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
            showHeaderMessage(message: "Input the missing fields")
            return false
        }else{
            hideHeaderMessage()
            return true
        }
    }
    
    // MARK: Header View: add a UI Label inside the section Header to display an inline message to the user
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        return headerLabel
    }
    // MARK: Hide the UILabel inside the header by changing its size to zero if it does not have a value, else it automatically resizes to the needed height
    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {

        if headerLabel == nil {
            return 0
        }
        return UITableView.automaticDimension
    }
  
    // MARK: Show Header
    func showHeaderMessage(message: String) {
        if headerLabel == nil {
            headerLabel = UILabel()
            headerLabel?.textAlignment = .center
            headerLabel?.font = UIFont.systemFont(ofSize: 14)
            headerLabel?.textColor = .systemRed
            headerLabel?.numberOfLines = 0
        }

        headerLabel?.text = message

        // Update layout safely
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    // MARK: Hide Header
    func hideHeaderMessage() {
        headerLabel = nil

        // Update layout safely
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // MARK: depending on what the user has selected in the picker view, set the Attribute value
        var best : Attribute;
        switch bestAtSelecteValue {
        case Attribute.attack.rawValue:
            best = Attribute.attack
        case Attribute.defence.rawValue:
            best = Attribute.defence
        case Attribute.speed.rawValue:
            best = Attribute.speed
        default:
            best = Attribute.speed
        }
        // MARK: modify only the allowed fields
        dragon.speed = Int(speedTextField.text!)!
        dragon.attack = Int(attackTextField.text!)!
        dragon.defence = Int(defenceTextField.text!)!
        dragon.bestAt = best
        
        let db = DragonsRepository.sharedDragonsRepository
        Task{
            do{
                try await db.updateDragon(dragon: dragon)
            }catch{
                print("Error: \(error)")
            }
        }
        
    }
    

}
