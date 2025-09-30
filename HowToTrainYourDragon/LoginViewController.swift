//
//  LoginViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/9/2025.
//

import UIKit
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let db = UserRepository.sharedUserRepository
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginDidPress(_ sender: Any)   {
        let newUser = User(id: emailTextField.text,
                           username: "KUMO",
                           firstname: "Kim",
                           lastname: "Morla",
                           dob: Date(),
//                           memberSince: Date(),
                           phone: "234234234")
        Task{
            do {
                try await db.addOrUpdateUser(user: newUser)
            } catch {
                //throw UserRepositoryError.firestoreError(error)
                print(UserRepositoryError.firestoreError(error))
            }
        }
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
