//
//  MyDragonsCollectionViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 22/8/2025.
//

import UIKit
import FirebaseFirestore

private let reuseIdentifier = "Cell"

class MyDragonsCollectionViewController: UICollectionViewController {

    var myDragons : [MyDragon] = []
    var selectedDragon : MyDragon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        loadMyDragons()
    }

    func loadMyDragons(){
//        myDragons.append(MyDragon(id: "11111", name: "Tommy", bloodline: "STOKER-TERRIBLE TERROR", attack: 20, defence: 15, speed: 40, acquiredOn: Timestamp(date: Date()), wins: 0, draws: 1, losses: 2))
//        myDragons.append(MyDragon(id: "22222", name: "Grump", bloodline: "BOULDER-HOTBURPLE", attack: 30, defence: 70, speed: 25, acquiredOn: Timestamp(date: Date()), wins: 1, draws: 0, losses: 1))
//        myDragons.append(MyDragon(id: "33333", name: "Toothless", bloodline: "STRIKE-NIGHT FURY", attack: 55, defence: 60, speed: 100, acquiredOn: Timestamp(date: Date()), wins: 0, draws: 0, losses: 0))
    }
    


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myDragons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyDragonsCollectionViewCell.identifier, for: indexPath) as! MyDragonsCollectionViewCell
    
        // Configure the cell
        let myDragon = myDragons[indexPath.item]
//        if let type = myDragon.bloodline.split(separator: "-").first, let species = myDragon.bloodline.split(separator: "-").last {
//            cell.setup(dragonName: myDragon.name, type: String(type), species: String(species), win: myDragon.wins, draw: myDragon.draws, loss: myDragon.losses)
//        
//        }
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedDragon = myDragons[indexPath.item]
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if let myDragonDetailsTVC = segue.destination as? MyDragonDetailsTableViewController {
            myDragonDetailsTVC.dragon = selectedDragon
        }
    }
    
    
    
}
