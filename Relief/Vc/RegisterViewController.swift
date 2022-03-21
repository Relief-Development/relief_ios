//
//  RegisterViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 25/1/22.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet var segmentregister: UISegmentedControl?
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var repeatPasswordTF: UITextField!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var eyeBtn: UIButton!
    @IBOutlet var eyeBtn2: UIButton!
    @IBOutlet var noDataView: UIView!

    
    var role: String = ""
    var response: Response?
    var eyeClick: Bool = false
    var eyeClick2: Bool = false
    var infoMessage: String? = "Encontramos algunos fallos en el formulario:\n"


    let nameRegEx = "^[A-ZÁÉÍÓÚ]{1}[a-zñáéíóú]+[\\s]+[A-ZÁÉÍÓÚ]{1}[a-zñáéíóú]{1,20}"
    let passRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}$"
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repeatPasswordTF?.attributedPlaceholder = getAttributeString("Repetir contraseña")
        self.passwordTF?.attributedPlaceholder = getAttributeString("Contraseña")
        self.nameTF?.attributedPlaceholder = getAttributeString("Nombre")
        self.emailTF?.attributedPlaceholder = getAttributeString("Email")
        overrideUserInterfaceStyle = .light
        passwordTF.isSecureTextEntry = true
        repeatPasswordTF.isSecureTextEntry = true

        


        func getAttributeString(_ string: String) -> NSAttributedString {
            return NSAttributedString(
                string: string,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "user_light")])
                
                }
    }
    
    @IBAction func buttonLoginTapped(_ sender: Any){
        
        let isNameValid = isValidInput(toCheck: nameTF.text!, regEx: nameRegEx)
        
        if !isNameValid && nameTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- Ingrese nombre y apellido iniciando en mayúsculas (máx. 50 caracteres)."
        }
        
        //        Comprobamos si el email cumple el patrón
        
        let isEmailValid = isValidInput(toCheck: emailTF.text!, regEx: emailRegEx)
        
        if !isEmailValid && emailTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- Ingrese un correo válido."
        }
        
        //        Comprobamos si la contraseña cumple el patrón
        
        let isPasswordValid = isValidInput(toCheck: passwordTF.text!, regEx: passRegEx)
        
        if !isPasswordValid && passwordTF.text != ""{
            self.infoMessage = "\(self.infoMessage!) \n- La contraseña debe tener 6 caracteres, que incluyan minúsculas, mayúsculas y números."
        }
        
        //        Comprobamos si la contraseña y la confirmacion de contraseña son iguales
        
        
        if passwordTF.text != repeatPasswordTF.text!{
            self.infoMessage = "\(self.infoMessage!) \n- Las contraseñas no son iguales"
        }
        
        //
        if segmentregister?.selectedSegmentIndex == 0 {
            role = "Usuario"

        }else if segmentregister?.selectedSegmentIndex == 1 {
            role = "Masajista"

        }else {
            self.infoMessage = "\(self.infoMessage!) \n- Seleccione el cargo del trabajador."
        }
        if infoMessage != "Encontramos algunos fallos en el formulario:\n"{
                    self.alert(message:infoMessage!, type: .actionSheet)
                    infoMessage = "Encontramos algunos fallos en el formulario:\n"
        }else{
            let params: [String: Any] = [
                "email": emailTF?.text ?? "",
                "password": passwordTF?.text ?? "",
                "name": nameTF?.text ?? "",
                "role": role ?? ""

            ]

            //print(params)

            DataMapper.shared.register(params: params) { response in
                if(response == nil){
                    DispatchQueue.main.async {
                        print("LA RESPUESTA ES")
                        print(response)
                        self.noDataView.isHidden = false
                        self.showAlert(title: "Error en la conexion")
                        self.emailTF.text = ""
                        self.passwordTF.text = ""
                        self.repeatPasswordTF.text = ""
                        self.nameTF.text = ""
                        self.segmentregister?.selectedSegmentIndex = UISegmentedControl.noSegment


                    }
                }else{
                    DispatchQueue.main.async {

                        self.response = response

                        if(response?.status == 0){
                            self.showAlert(title: (response?.msg)!)

                        }else if response?.status == 1{
                            self.emailTF.text = ""
                            self.passwordTF.text = ""
                            self.repeatPasswordTF.text = ""
                            self.nameTF.text = ""
                            self.segmentregister?.selectedSegmentIndex = UISegmentedControl.noSegment
                            self.showAlert(title: (response?.msg)!)

                        }else if response?.status == 2{
                            self.showAlert(title: (response?.msg)!)
                        }else if response?.status == 3{
                            self.showAlert(title: (response?.msg)!)
                        }
                    }
                }
            }
        }
    
    }
    @IBAction func buttonToLoginTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func eyePassTapped(_ sender: UIButton) {
            passwordTF.isSecureTextEntry = eyeClick
            eyeClick.toggle()
            eyeBtn.isSelected = eyeClick
    }
    
    @IBAction func eyePassTapped2(_ sender: UIButton) {
            repeatPasswordTF.isSecureTextEntry = eyeClick2
            eyeClick2.toggle()
            eyeBtn2.isSelected = eyeClick2
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    public func isValidInput(toCheck: String, regEx: String) -> Bool {
           
           var returnValue = true
           
           do {
               let regex = try NSRegularExpression(pattern: regEx)
               let nsString = toCheck as NSString
               let results = regex.matches(in: toCheck, range: NSRange(location: 0, length: nsString.length))
               
               if results.count == 0
               {
                   returnValue = false
               }
               
           } catch let error as NSError {
               print("invalid regex: \(error.localizedDescription)")
               returnValue = false
           }
           
           return  returnValue
    }
    public func alert(message:String, type:UIAlertController.Style) {
            let alert = UIAlertController(title: message, message: nil, preferredStyle: type)
            
            let confirmAction = UIAlertAction(title: "Continuar", style: .default){
                action in
                //            self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
    }
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
//            self.chargeView.isHidden = true
            self.noDataView.isHidden = true
            
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }
}
