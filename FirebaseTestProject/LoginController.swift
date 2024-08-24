//
//  LoginController.swift
//  FirebaseTestProject
//
//  Created by Zahra Alizada on 23.08.24.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullname: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func registerTappedButton(_ sender: Any) {
        let controller =  storyboard?.instantiateViewController(withIdentifier: "RegisterController") as! RegisterController
        controller.userCallback = { email, password in
            self.email.text = email
            self.password.text = password
        }
        
        
        navigationController?.show(controller, sender: nil)
    }
    
    @IBAction func loginTappedButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: email.text ?? "", password: password.text ?? "") { [weak self] authResult, error in
            guard self != nil else { return }
            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self?.navigationController?.show(controller, sender: nil)
        }
        
        
    }
    
   
}
