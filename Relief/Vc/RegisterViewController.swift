//
//  RegisterViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 25/1/22.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet var segmentregister: UISegmentedControl?
    @IBOutlet var userTF: UITextField?
    @IBOutlet var passwordTF: UITextField?
    @IBOutlet var nameTF: UITextField?
    @IBOutlet var emailTF: UITextField?
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTF?.attributedPlaceholder = getAttributeString("Usuario")
        self.passwordTF?.attributedPlaceholder = getAttributeString("Contraseña")
        self.nameTF?.attributedPlaceholder = getAttributeString("Nombre")
        self.emailTF?.attributedPlaceholder = getAttributeString("Email")
        overrideUserInterfaceStyle = .light
        


        func getAttributeString(_ string: String) -> NSAttributedString {
            return NSAttributedString(
                string: string,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")])
                
                }
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any){
        if segmentregister?.selectedSegmentIndex == 0{
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "TutorialUser1"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
        }else if segmentregister?.selectedSegmentIndex == 1{
            if let homemassage = storyboard?.instantiateViewController(withIdentifier: "TutorialMassage1"){
                homemassage.modalPresentationStyle = .fullScreen
                self.present(homemassage, animated: true, completion: nil)
            }
        }else {
            let alertController = UIAlertController(title: nil, message: "Seleccione un tipo de usuario para registrarse", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in alertController.dismiss(animated: true, completion: nil) })
        }
    }
    @IBAction func buttonToLoginTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
