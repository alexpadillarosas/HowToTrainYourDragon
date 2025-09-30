//
//  LoginViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/9/2025.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let db = UsersRepository.sharedUserRepository
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginDidPress(_ sender: Any)   {
        
        guard !emailTextField.text.isBlank else{
            showAlertMessage(title: "Validation", message: "Email is mandatory")
            return
        }
        guard emailTextField.text.isValidEmail else{
            showAlertMessage(title: "Validation", message: "Invalid Email format")
            return
        }
        guard !passwordTextField.text.isBlank else{
            showAlertMessage(title: "Validation", message: "Password is mandatory")
            return
        }
        
        //we use an implicitly unwrapped optional (!) because at this point in the code we are sure emailTextField.text and passwordTextField.text have values (check guards above)
        let email = emailTextField.text!
        let password = passwordTextField.text!
//        logInActivityIndicatorView.startAnimating()
        //Since the last parameter is a closure we can call it trailing closure
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            //guard to check we did not get an error after calling firebase authentication signIn method
            guard error == nil else {
                self?.showAlertMessage(title: "Failed to log in", message: "\(error!.localizedDescription)")
//                self?.logInActivityIndicatorView.stopAnimating()
                return
            }
            //guard to check the user has been registered with Firebase Authentication and also the email sent was verified by the user
            guard let authUser = Auth.auth().currentUser, authUser.isEmailVerified else{
                self?.showAlertMessage(title: "Pending email verification", message: "We've sent you an email to verify your account, please follow the instructions")
//                self?.logInActivityIndicatorView.stopAnimating()
                return
            }
            
            // programmatically navigate to HomeVC
            let homeViewController = self?.storyboard?.instantiateViewController(identifier: "HomeVC") as? UITabBarController
                
            self?.view.window?.rootViewController = homeViewController
            self?.view.window?.makeKeyAndVisible()
                
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
