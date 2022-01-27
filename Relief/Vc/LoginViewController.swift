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
    @IBOutlet var userTF: UITextField?
    @IBOutlet var passwordTF: UITextField?
    private var textField: UITextField?
    private var placeholder: String?

    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn?.layer.borderWidth = 1
        self.registerBtn?.layer.cornerRadius = 6
        self.registerBtn?.layer.borderColor = UIColor(named: "tabbarback")?.cgColor
        self.userTF?.attributedPlaceholder = NSAttributedString(
            string: "Usuario",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")]
        )
        self.passwordTF?.attributedPlaceholder = NSAttributedString(
            string: "Contraseña",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")]
        )
       
    }
    @IBAction func buttonRegisterTapped(_ sender: Any){
        if let register = storyboard?.instantiateViewController(withIdentifier: "Register"){
            register.modalPresentationStyle = .fullScreen
            self.present(register, animated: true, completion: nil)
        }
        
    }
    @IBAction func buttonLoginTapped(_ sender: Any){
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
        
    }
    private func rederPlaceholder(placeholder: String, textField:UITextField){
        self.textField?.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")]
        )
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
 
