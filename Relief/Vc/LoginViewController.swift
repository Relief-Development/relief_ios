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
    @IBAction func buttonRegisterTapped(_ sender: Any){
        if let register = storyboard?.instantiateViewController(withIdentifier: "Register"){
            register.modalPresentationStyle = .fullScreen
            self.present(register, animated: true, completion: nil)
        }
        
    }
    @IBAction func buttonLoginTapped(_ sender: Any){
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "home"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
        
    }
}
