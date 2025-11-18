//
//  ProfileTableViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 26/8/2025.
//

import UIKit
import FirebaseAuth

class ProfileTableViewController: UITableViewController {

    let db = UsersRepository.sharedUserRepository
    var loggedInUser : User!
    var userId : String!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var dobDatePicker: UIDatePicker!

    @IBOutlet weak var memberSinceDatePicker: UIDatePicker!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        userId = Auth.auth().currentUser?.email  // get the userId : logged in user
            
        Task{
            do{
                try loggedInUser = await db.getUserByID(userID: userId!)
                //set all values in the UI
                setUIFields(userId: userId, user: loggedInUser);
                
            }catch{
                print("Error: \(error)")
            }
        }
        
    }

    private func setUIFields(userId : String, user: User) {
        usernameLabel.text = user.username ?? ""
        userEmailLabel.text = userId //because we use as PK (id) the email
        
        firstnameTextField.text = user.firstname ?? ""
        lastnameTextField.text = user.lastname ?? ""
        usernameTextField.text = user.username ?? ""
        
        phoneTextField.text = user.phone ?? ""
        
        if let dob = user.dob {
            dobDatePicker.date = dob
        }
        
        if let msince = user.memberSince {
            memberSinceDatePicker.date = msince
        }
    }

    @IBAction func logoutDidPress(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            print("Successfully logged out")
            
            let logoutClosure = {
                // programmatically navigate to LoginViewController
                //LoginVC is the Storyboard Id given to the Login UI View Controller in Storyboard
                let loginViewController = self.storyboard?.instantiateViewController(identifier: "LoginVC") as? UIViewController
                    
                self.view.window?.rootViewController = loginViewController
                self.view.window?.makeKeyAndVisible()
            }
            
            showConfirmationMessage(title: "Confirm", message: "Are you sure you want to LogOut?",
                                    ok: {
                                        logoutClosure()
                                    },
                                    cancel: {
                                        print("Cancelled")
                                    })
                
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
    @IBAction func saveDidPress(_ sender: Any) {
        
        loggedInUser.firstname = firstnameTextField.text
        loggedInUser.lastname = lastnameTextField.text
        loggedInUser.phone = phoneTextField.text
        loggedInUser.dob = dobDatePicker.date
        
        Task{
            do{
                try await db.addOrUpdateUser(user: loggedInUser)
            }catch{
                print("Error: \(error)")
            }
        }
    }
    
    
    @IBAction func cancelDidPress(_ sender: Any) {
        
        setUIFields(userId: userId, user: loggedInUser)
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
