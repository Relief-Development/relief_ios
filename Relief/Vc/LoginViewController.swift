//
//  LoginViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 25/1/22.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet var loginBtn: UIButton?
    @IBOutlet var registerBtn: UIButton?
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn?.layer.borderWidth = 1
        self.registerBtn?.layer.cornerRadius = 6
        self.registerBtn?.layer.borderColor = UIColor(named: "tabbarback")?.cgColor
       
    }
    @IBAction func buttonRegisterTapped(){
        if let register = mainstoryboard.instantiateViewController(withIdentifier: "Register") as? RegisterViewController{
            view.window?.rootViewController = register
        }
        
    }
    @IBAction func buttonLoginTapped(){
        if let homeuser = mainstoryboard.instantiateViewController(withIdentifier: "homeuser") as? HomeViewController{
            view.window?.rootViewController = homeuser
        }
        
    }
}
