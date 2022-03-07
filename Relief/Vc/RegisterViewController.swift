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
//        if segmentregister?.selectedSegmentIndex == 0 {
//            puesto = "Usuario"
//
//        }else if segmentregister?.selectedSegmentIndex == 1 {
//            puesto = "Masajista"
//
//        }else {
//            self.Alert(title: "Selecciona el tipo de usuario que quieres crear")
//
//        }
//        if(nameTF?.text == "" || passwordTF?.text == "" || repeatPasswordTF?.text == "" || userTF?.text == "" || emailTF?.text == ""){
//            self.Alert(title: "Rellena todos los campos")
//
//        }else if passwordTF.text != repeatPasswordTF.text {
//            self.Alert(title: "Las contraseñas no coinciden")
//
//        }else{
//            let params: [String: Any] = [
//                "email": emailTF?.text ?? "",
//                "password": passwordTF?.text ?? "",
//                "name": nameTF?.text ?? "",
//                "user": userTF?.text ?? ""
//
//            ]
//
//            //print(params)
//
//            DataMapper.shared.register(params: params) { response in
//                if(response == nil){
//                    self.Alert(title: "Error en la conexion")
//                }else{
//                    DispatchQueue.main.async {
//
//                        self.response = response
//
//                        if(response?.status == 0){
//                            self.Alert(title: (response?.msg)!)
//
//                        }else if response?.status == 1{
//                            self.emailTF.text = ""
//                            self.passwordTF.text = ""
//                            self.repeatPasswordTF.text = ""
//                            self.nameTF.text = ""
//                            self.userTF.text = ""
//                            self.segmentregister?.selectedSegmentIndex = UISegmentedControl.noSegment
//
//
//                            self.Alert(title: (response?.msg)!)
//
//                        }else if response?.status == 401{
//                            self.Alert(title: (response?.msg)!)
//                        }
//                    }
//                }
//            }
//        }
    
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
