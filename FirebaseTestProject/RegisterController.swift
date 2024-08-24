//
//  RegisterController.swift
//  FirebaseTestProject
//
//  Created by Zahra Alizada on 23.08.24.
//

import UIKit
import FirebaseAuth

class RegisterController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullname: UITextField!
    
    var userCallback: ((String, String) -> Void)?
    
    var userAuth: UserAuth?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func registerTappedButton(_ sender: Any) {
        
        if let email = email.text, !email.isEmpty,
           let password = passwordTF.text, !password.isEmpty {
                
                Auth.auth().createUser(withEmail: email, 
                                       password: password) { result, error in
                    if let user = result?.user {
                        let email = user.email ?? ""
                        print(email)
                        
                        self.userCallback?(email, password)
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    } else {
                        print(error?.localizedDescription ?? "")
                    }
                    
                }
                
            }
            
        }
        
    }
    

