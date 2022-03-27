//
//  EditUserProfileVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit
import AVFoundation

class EditUserProfileVC: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate,  UINavigationControllerDelegate{
    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var nameTf: UITextField!
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var passwordTf: UITextField!
    @IBOutlet var rpasswordTf: UITextField!
    @IBOutlet var chargeView: UIView!


    var response: Response?
    let picker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.layer.borderColor = UIColor(named: "user")?.cgColor
        imageProfile.layer.borderWidth = 5
        nameTf.delegate = self
        emailTf.delegate = self
        rpasswordTf.delegate = self
        passwordTf.delegate = self

        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        overrideUserInterfaceStyle = .light
       
    }
    @IBAction func buttonToProfileTapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let imageP = UserDefaults.standard.object(forKey: "image") as? String{
            if imageP != ""{
                let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                var decodedimage = UIImage(data: decodedData as! Data)
                //print(decodedimage)
                imageProfile.image = decodedimage as! UIImage
               
            }else{
                imageProfile.image = UIImage(systemName: "person.circle.fill")
            }
            imageProfile.layer.borderColor = UIColor(named: "user")?.cgColor
            imageProfile.layer.borderWidth = 5
            imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        }
        if let nameP = UserDefaults.standard.object(forKey: "name") as? String{
            print(nameP)
            nameTf!.text = nameP
        }
        if let emailP = UserDefaults.standard.object(forKey: "email") as? String{
            print(emailP)
            emailTf!.text = emailP
        }
        
        

    }
    @IBAction func saveTapped(){
        self.chargeView.isHidden = false
        if passwordTf.text != rpasswordTf.text {
                    self.showAlert(title: "Las contraseñas no coinciden")
        
                }else{
                    let params: [String: Any] = [
                        "email": emailTf?.text ?? "",
                        "password": passwordTf?.text ?? "",
                        "name": nameTf?.text ?? "",
                        "image": UserDefaults.standard.object(forKey: "image") as? String ?? "",
                        "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? "",
                        "services": []
        
                    ]
                
                    DataMapper.shared.editProfile(params: params) { response in
                        if(response == nil){
                            self.showAlert(title: "Error en la conexion")
                            self.chargeView.isHidden = true
                        }else{
                            DispatchQueue.main.async {
                                self.chargeView.isHidden = true
                                self.response = response
                                if(response?.status == 0){
                                    self.showAlert(title: (response?.msg)!)
        
                                }else if response?.status == 1{
                                    let name = self.nameTf.text
                                    UserDefaults.standard.set(name, forKey: "name")
                                    let email = self.emailTf.text
                                    UserDefaults.standard.set(email, forKey: "email")
                                    self.showAlert(title: (response?.msg)!)
        
                                }else if response?.status == 401{
                                    self.showAlert(title: (response?.msg)!)
                                }
                            }
                        }
                    }
                }
        
    }
    @IBAction func buttonImageTapped(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = UIColor(named: "user")

        let camara = UIAlertAction(title: "Hacer foto", style: .default, handler: {(action) in
            self.picker.sourceType = .camera
            self.picker.cameraCaptureMode = .photo
            self.picker.allowsEditing = true
            self.picker.delegate = self
            self.present(self.picker, animated: true)
        })
        let galeria = UIAlertAction(title: "Seleccionar foto", style: .default, handler: {(action) in
            
            self.picker.sourceType = .photoLibrary
            self.picker.delegate = self
            self.picker.allowsEditing = true
            self.present(self.picker, animated: true)
        })
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel  , handler: {(action) in
            
        })
        alertController.addAction(camara)
        alertController.addAction(galeria)
        alertController.addAction(cancelar)

        self.present(alertController, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        imageProfile.image = image
        imageProfile.layer.borderColor = UIColor(named: "user")?.cgColor
        imageProfile.layer.borderWidth = 5
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        UserDefaults.standard.set(convertImageToBase64(image: image), forKey: "image")

    }
    func convertImageToBase64(image: UIImage) -> String{
        let imageData = image.jpegData(compressionQuality: 0.6)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
    }
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    func registerAppointments(){
        
    }
    
}
