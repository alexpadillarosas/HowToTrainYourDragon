//
//  MarketplaceTableViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 20/8/2025.
//

import UIKit

class MarketplaceTableViewController: UITableViewController {
    
    var dragons : [Dragon] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadDragons()
        
        // Grouping by 'category'
//        let sections = Dictionary(grouping: dragons, by: { $0.type })
    }
    
    func loadDragons() {
        dragons.append(Dragon(type: "BOULDER", species: "HOTBURPLE", bestAt: Dragon.Attribute.defence, attack: 45, defence: 80, speed: 32))
        dragons.append(Dragon(type: "BOULDER", species: "GRONCKLE", bestAt: Dragon.Attribute.defence, attack: 40, defence: 81, speed: 37))
        dragons.append(Dragon(type: "STRIKE", species: "NIGHT FURY", bestAt: Dragon.Attribute.attack, attack: 79, defence: 36, speed: 69))
        dragons.append(Dragon(type: "STRIKE", species: "LIGHT FURY", bestAt: Dragon.Attribute.attack, attack: 79, defence: 32, speed: 54))
        dragons.append(Dragon(type: "TRACKER", species: "DEADLY NADDER", bestAt: Dragon.Attribute.defence, attack: 50, defence: 75, speed: 54))
        dragons.append(Dragon(type: "STOCKER", species: "TERRIBLE TERROR", bestAt: Dragon.Attribute.speed, attack: 35, defence: 25, speed: 72))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dragons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketplaceTableViewCell.identifier, for: indexPath) as! MarketplaceTableViewCell

        // Configure the cell...
        let dragon = dragons[indexPath.row]
        cell.setup(dragon: dragon)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
