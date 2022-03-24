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
        self.userTF?.attributedPlaceholder = getAttributeString("Email")
        self.passwordTF?.attributedPlaceholder = getAttributeString("Contraseña")
        overrideUserInterfaceStyle = .light
        passwordTF.isSecureTextEntry = true
        
        
       
    }
//    override func viewWillAppear(_ animated: Bool) {
//        if let roll = UserDefaults.standard.object(forKey: "role") as? String{
//            AppData.shared.role = roll
//            print("Este es el role")
//            print(roll)
//        }
//        if AppData.shared.role == "Usuario"{
//            if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
//                homeuser.modalPresentationStyle = .fullScreen
//                self.present(homeuser, animated: true, completion: nil)
//            }
//        }else if AppData.shared.role == "Masajista"{
//            if let homemassage = self.storyboard?.instantiateViewController(withIdentifier: "homeMassage2"){
//                        homemassage.modalPresentationStyle = .fullScreen
//                            self.present(homemassage, animated: true, completion: nil)
//                    }
//        }
//    }
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
            self.showAlert(title: "Los campos de usuario o de contraseña estan vacios")
        }else{
            self.chargeView.isHidden = false
            let params: [String: Any] = [
                "email": userTF?.text ?? "",
                "password": passwordTF?.text ?? ""
            ]
            print(params)
            DataMapper.shared.login(params: params) { response in
                if(response == nil){
                    DispatchQueue.main.async {
                        print("LA RESPUESTA ES")
                        print(response)
                        self.chargeView.isHidden = true
                        self.noDataView.isHidden = false
                        self.showAlert(title: "Error en la conexion")
                        self.userTF?.text = ""
                        self.passwordTF.text = ""

                    }

                }else{
                    DispatchQueue.main.async {
                        self.response = response
                        if(response?.status == 0){
                            self.showAlert(title: (response?.msg)!)
                        }else if response?.status == 1{
                            AppData.shared.imageProfile = self.response?.profile?[0].image ?? ""
                            AppData.shared.name = self.response?.profile?[0].name ?? ""
                            AppData.shared.email = self.response?.profile?[0].email ?? ""
                            AppData.shared.created_at = self.response?.profile?[0].created_at ?? ""
                            AppData.shared.apiToken = self.response?.token ?? ""
                            AppData.shared.lat =  self.response?.profile?[0].lat ?? 0.0
                            AppData.shared.long =  self.response?.profile?[0].long ?? 0.0
                            AppData.shared.address = self.response?.profile?[0].address ?? ""
                            AppData.shared.description = self.response?.profile?[0].description ?? ""
                            AppData.shared.role = self.response?.profile?[0].role ?? ""
                            AppData.shared.id = self.response?.profile?[0].id ?? 0
                            AppData.shared.phone_number = self.response?.profile?[0].phone_number ?? ""


                            let apitoken = AppData.shared.apiToken
                            UserDefaults.standard.set(apitoken, forKey: "token")
                            
                            let name = AppData.shared.name
                            UserDefaults.standard.set(name, forKey: "name")
                            
                            let role = AppData.shared.role
                            UserDefaults.standard.set(role, forKey: "role")
                            
                            let email = AppData.shared.email
                            UserDefaults.standard.set(email, forKey: "email")
                            
                            let address = AppData.shared.address
                            UserDefaults.standard.set(address, forKey: "address")
                            
                            let description = AppData.shared.description
                            UserDefaults.standard.set(description, forKey: "description")
                            
                            let created = AppData.shared.created_at
                            UserDefaults.standard.set(created, forKey: "created")
                            
                            let image = AppData.shared.imageProfile
                            UserDefaults.standard.set(image, forKey: "image")
                            
                            let id = AppData.shared.id
                            UserDefaults.standard.set(image, forKey: "id")
                            
                            let phone = AppData.shared.phone_number
                            UserDefaults.standard.set(phone, forKey: "phone_number")
                            
                            let lat = AppData.shared.lat
                            UserDefaults.standard.set(lat, forKey: "lat")
                            
                            let long = AppData.shared.long
                            UserDefaults.standard.set(long, forKey: "long")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("")
                            print("ROLE")
                            print(UserDefaults.standard.object(forKey: "role") as! String)

                            print(image)

                            self.chargeView.isHidden = true
                            if response?.profile?[0].role == "Masajista"{
                                if let homemassage = self.storyboard?.instantiateViewController(withIdentifier: "HomeMassage"){
                                            homemassage.modalPresentationStyle = .fullScreen
                                                self.present(homemassage, animated: true, completion: nil)
                                        }
                            }else if response?.profile?[0].role == "Usuario"{
                                if let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
                                    homeuser.modalPresentationStyle = .fullScreen
                                    self.present(homeuser, animated: true, completion: nil)
                                }
                            }
                        
                        }else if response?.status == 2{
                            self.chargeView.isHidden = true
                            self.showAlert(title: (response?.msg)!)
                        }else if response?.status == 3{
                            self.chargeView.isHidden = true
                            self.showAlert(title: (response?.msg)!)
                        }
                    }


                }
            }
        }
        
        
//else {
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
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.chargeView.isHidden = true
            self.noDataView.isHidden = true
            self.userTF?.text = ""
            self.passwordTF.text = ""
            
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }

}
 
