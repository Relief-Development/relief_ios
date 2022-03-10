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
    @IBOutlet var eyeBtn: UIButton!
    @IBOutlet var userTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var chargeView: UIView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var spinner: UIActivityIndicatorView?
    
    var response: Response?

    private var textField: UITextField?
    private var placeholder: String?
    var eyeClick: Bool = false

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
        passwordTF.isSecureTextEntry = true
       
    }
    @IBAction func buttonRegisterTapped(_ sender: Any){
        if let register = storyboard?.instantiateViewController(withIdentifier: "Register"){
            register.modalPresentationStyle = .fullScreen
            self.present(register, animated: true, completion: nil)
        }
        
    }
    @IBAction func eyePassTapped(_ sender: UIButton) {
            passwordTF.isSecureTextEntry = eyeClick
            eyeClick.toggle()
            eyeBtn.isSelected = eyeClick
        }
    @IBAction func buttonLoginTapped(_ sender: Any){
        if(userTF?.text == "" || passwordTF?.text == "" ){
            self.Alert(title: "Los campos de usuario o de contraseña estan vacios")
        }else{
            self.chargeView.isHidden = false
            let params: [String: Any] = [
                "username": userTF?.text ?? "",
                "password": passwordTF?.text ?? ""
            ]
            print(params)
            DataMapper.shared.login(params: params) { response in
                if(response == nil){
                    DispatchQueue.main.async {
                        print("LA RESPUESTA ES")
                        print(response)
                        self.spinner?.removeFromSuperview()
                        self.noDataView.isHidden = false
                        self.Alert(title: "Error en la conexion")
                        self.userTF?.text = ""
                        self.passwordTF.text = ""

                    }

                }else{
                    DispatchQueue.main.async {

                        self.response = response

                        if(response?.status == 0){
                            self.Alert(title: (response?.msg)!)
                        }else if response?.status == 1{
                            //print(self.response?.listaempleados)
                            AppData.shared.imageProfile = self.response?.image ?? ""
                            AppData.shared.name = self.response?.profile?[0].name ?? ""
                            AppData.shared.created_at = self.response?.profile?[0].created_at ?? ""

                            AppData.shared.apiToken = self.response?.msg ?? ""
                            let apitoken = AppData.shared.apiToken
                            UserDefaults.standard.set(apitoken, forKey: "token")
                            let name = AppData.shared.name
                            UserDefaults.standard.set(name, forKey: "name")
                            let created = AppData.shared.created_at
                            UserDefaults.standard.set(created, forKey: "created")
                            let image = AppData.shared.imageProfile
                            UserDefaults.standard.set(image, forKey: "image")

                            //let puesto = AppData.shared.puesto
                            //UserDefaults.standard.set(puesto, forKey: "puesto")

                            if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
                                homeuser.modalPresentationStyle = .fullScreen
                                self.present(homeuser, animated: true, completion: nil)
                                self.chargeView.isHidden = true
                            }
                        }else if response?.status == 2{
                            self.Alert(title: (response?.msg)!)
                        }
                    }


                }
            }
        }
        
        
//        if(userTF?.text == "Marta" && passwordTF?.text == "1234"){
//            if let homeuser = storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
//                homeuser.modalPresentationStyle = .fullScreen
//                self.present(homeuser, animated: true, completion: nil)
//            }
//        }else if (userTF?.text == "Esther" && passwordTF?.text == "1234"){
//            if let homemassage = storyboard?.instantiateViewController(withIdentifier: "HomeMassage"){
//                homemassage.modalPresentationStyle = .fullScreen
//                self.present(homemassage, animated: true, completion: nil)
//            }
//        }else {
//            let alertController = UIAlertController(title: nil, message: "Ese usuario no esta registrado", preferredStyle: .alert)
//            self.present(alertController, animated: true, completion: nil)
//            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alertController.dismiss(animated: true, completion: nil) })
//        }
        
        
    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    func getAttributeString(_ string: String) -> NSAttributedString {
        return NSAttributedString(
            string: string,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")])
            
            }
    func Alert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.chargeView.isHidden = true
            self.noDataView.isHidden = true
            
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }

}
 
