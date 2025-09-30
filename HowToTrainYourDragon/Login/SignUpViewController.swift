//
//  SignUpViewController.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/9/2025.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let db = UsersRepository.sharedUserRepository
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpDidPress(_ sender: Any) {
        
        guard !usernameTextField.text.isBlank else{
            showAlertMessage(title: "Validation", message: "Username is mandatory")
            return
        }
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
        guard !confirmPasswordTextField.text.isBlank else{
            showAlertMessage(title: "Validation", message: "Confirm Password is mandatory")
            return
        }
        //multiple unwraps in a guard: we want to get the values, not the optionals.
        guard   let username = usernameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text ,
                let confirmation = confirmPasswordTextField.text, password == confirmation else {
                showAlertMessage(title: "Validation", message: "Password and Password Confirmation do not match")
            return
        }
        
//        let registerUserClosure : () -> Void = {
//
//            let newUser = User(id: email,
//                               username: username,
//                               firstname: "",
//                               lastname: "",
//                               dob: Date(),
//                               memberSince: Date(),
//                               phone: "")
//            Task{
//                do {
//                    try await self.db.addOrUpdateUser(user: newUser)
//                    
//                    self.navigationController?.popViewController(animated: true)
//                } catch {
//                    //throw UserRepositoryError.firestoreError(error)
//                    print(UserRepositoryError.firestoreError(error))
//                }
//            }
//            
//        }
        
        /*
         This function createUser receives as last parameter a closure:
         Since the last parameter is a closure we can call it trailing closure therefore, we can place the closure outside
         the function's parentheses. after the open and close curly braces.
         This function as seen in the source code, receives a result and an error
         */
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            //guard there were no errors while creating the user.
            guard error == nil else {
                self.showAlertMessage(title: "We could not create the account", message: "\(error!.localizedDescription)")
//                self.logInActivityIndicatorView.stopAnimating()
                return
            }
//            self.showAlertMessage(title: "yay", message: "user registered, UID: \(authResult!.user.uid)")
            
            /**
             This function send an email to the user, to confirm the account
             */
            Auth.auth().currentUser?.sendEmailVerification{ error in
                guard error == nil else{
                    self.showAlertMessage(title: "Error", message: "\(error!)")
//                    self.logInActivityIndicatorView.stopAnimating()
                    return
                }
                
                //We need to register the user in the users collection
                let newUser = User(id: email,
                                   username: username,
                                   firstname: "",
                                   lastname: "",
                                   dob: Date(),
                                   memberSince: Date(),
                                   phone: "")
                Task{
                    do {
                        try await self.db.addOrUpdateUser(user: newUser)
                        //Closure to navigate to the previous screen
                        let navigateToLogInClosure : () -> Void = {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        self.showAlertMessageWithHandler(title: "Email Confirmation Sent", message: "A confirmation email has been sent to you email account, please confirm your account before you log in", onComplete: navigateToLogInClosure )
                        
                        
                    } catch {
                        //throw UserRepositoryError.firestoreError(error)
                        print(HttydError.firestoreError(error))
                        self.showAlertMessage(title: "Error", message: "\(error)")
                    }
                }
                

                
//                self.logInActivityIndicatorView.stopAnimating()
//                self.showAlertMessageWithHandler(title: "Email Confirmation Sent",
//                                                 message: "A confirmation email has been sent to you email account, please confirm your account before you log in",
//                                                 onComplete: registerUserClosure)
                

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
