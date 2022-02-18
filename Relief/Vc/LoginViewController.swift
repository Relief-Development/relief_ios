//
//  LoginViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 25/1/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
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
        userTF?.delegate = self
        passwordTF?.delegate = self
        self.registerBtn?.layer.borderColor = UIColor(named: "tabbarback")?.cgColor
        self.userTF?.attributedPlaceholder = getAttributeString("Usuario")
        self.passwordTF?.attributedPlaceholder = getAttributeString("Contraseña")
        overrideUserInterfaceStyle = .light
       
    }
    @IBAction func buttonRegisterTapped(_ sender: Any){
        if let register = storyboard?.instantiateViewController(withIdentifier: "Register"){
            register.modalPresentationStyle = .fullScreen
            self.present(register, animated: true, completion: nil)
        }
        
    }
    @IBAction func buttonLoginTapped(_ sender: Any){
        
        if(userTF?.text == "Marta" && passwordTF?.text == "1234"){
            if let homeuser = storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
                homeuser.modalPresentationStyle = .fullScreen
                self.present(homeuser, animated: true, completion: nil)
            }
        }else if (userTF?.text == "Ester" && passwordTF?.text == "1234"){
            if let homemassage = storyboard?.instantiateViewController(withIdentifier: "HomeMassage"){
                homemassage.modalPresentationStyle = .fullScreen
                self.present(homemassage, animated: true, completion: nil)
            }
        }else {
            let alertController = UIAlertController(title: nil, message: "Ese usuario no esta registrado", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alertController.dismiss(animated: true, completion: nil) })
        }
        
        
    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    func getAttributeString(_ string: String) -> NSAttributedString {
        return NSAttributedString(
            string: string,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")])
            
            }


}
 
