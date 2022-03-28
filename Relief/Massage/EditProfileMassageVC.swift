//
//  EditProfileMassageVC.swift
//  Relief
//
//  Created by Alejandro Botana on 8/2/22.
//

import UIKit
import CoreLocation

class EditProfileMassageVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, ModalUbicationMassageVCDelegate, ModalMassagesVCDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    
    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var addressTf: UITextField!
    @IBOutlet var nameTf: UITextField!
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var passwordTf: UITextField!
    @IBOutlet var rpasswordTf: UITextField!
    @IBOutlet var descriptionTF: UITextView!
    @IBOutlet var massageTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var chargeView: UIView!
    
    
    
    var response: Response?
    var lat: Float = 0.0
    var long: Float = 0.0
    var adressU: String = ""
    
    
    let picker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.layer.borderColor = UIColor(named: "masssage")?.cgColor
        imageProfile.layer.borderWidth = 5
        nameTf.delegate = self
        emailTf.delegate = self
        addressTf.delegate = self
        rpasswordTf.delegate = self
        passwordTf.delegate = self
        phoneTF.delegate = self
        descriptionTF.delegate = self
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        overrideUserInterfaceStyle = .light
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToUbicationSegue" {
            let ubicationVC = segue.destination as! ModalUbicationMassageVC
            ubicationVC.delegate = self
        }
        if segue.identifier == "EditToMassagesSegue" {
            let masaggesVC = segue.destination as! ModalMassagesVC
            masaggesVC.delegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        descriptionTF.layer.cornerRadius = 6
        descriptionTF.layer.borderColor = UIColor(named: "gray2")?.cgColor
        descriptionTF.layer.borderWidth = 1
        if let imageP = UserDefaults.standard.object(forKey: "image") as? String{
            if imageP != ""{
                let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                var decodedimage = UIImage(data: decodedData as! Data)
                //print(decodedimage)
                imageProfile.image = decodedimage as! UIImage
                
            }else{
                imageProfile.image = UIImage(systemName: "person.circle.fill")
            }
            imageProfile.layer.borderColor = UIColor(named: "massage")?.cgColor
            imageProfile.layer.borderWidth = 5
            imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        }
        if let nameP = UserDefaults.standard.object(forKey: "name") as? String{
            nameTf!.text = nameP
        }
        if let massageP = UserDefaults.standard.object(forKey: "Massage") as? String{
            massageTF!.text = massageP
        }
        if let emailP = UserDefaults.standard.object(forKey: "email") as? String{
            print(emailP)
            emailTf!.text = emailP
        }
        if let ubicationP = UserDefaults.standard.object(forKey: "address") as? String{
            // if ubicationP != ""{
            addressTf.text = ubicationP
            //}
        }
        if let descriptionP = UserDefaults.standard.object(forKey: "description") as? String{
            // if ubicationP != ""{
            descriptionTF.text = descriptionP
            //}
        }
        if let phone = UserDefaults.standard.object(forKey: "phone_number") as? String{
            // if ubicationP != ""{
            phoneTF.text = phone
            //}
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
                "description": descriptionTF.text ?? "",
                "image": UserDefaults.standard.object(forKey: "image") as? String ?? "",
                "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? "",
                "lat": lat,
                "long": long,
                "address": UserDefaults.standard.object(forKey: "address") as? String ?? "",
                "phone_number": phoneTF?.text ?? "",
                "services": UserDefaults.standard.object(forKey: "Massage") as? Array ?? []
                
            ]
            
            print(params)
            
            DataMapper.shared.editProfile(params: params) { response in
                print("AQUI ESTA LA RESPUESTA")
                print(response)
                if(response == nil){
                    self.chargeView.isHidden = true
                    self.showAlert(title: "Error en la conexion")
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
                            let description = self.descriptionTF.text
                            UserDefaults.standard.set(description, forKey: "description")
                            let phone = self.phoneTF.text
                            UserDefaults.standard.set(phone, forKey: "phone_number")
                            self.showAlert(title: (response?.msg)!)
                            
                        }else if response?.status == 401{
                            self.showAlert(title: (response?.msg)!)
                        }
                    }
                }
            }
        }
        
    }
    @IBAction func buttonToProfileTapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func buttonImageTapped(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tintColor = UIColor(named: "massage")
        
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
        imageProfile.layer.borderColor = UIColor(named: "massage")?.cgColor
        imageProfile.layer.borderWidth = 5
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        UserDefaults.standard.set(convertImageToBase64(image: image), forKey: "image")
    }
    
    // MARK: - ModalUbicationVC delegate
    func modalUbicationVC(_ modalUbicationVC: ModalUbicationMassageVC, didFinishWithAddress address: String) {
        if let ubicationP = UserDefaults.standard.object(forKey: "address") as? String{
            // if ubicationP != ""{
            addressTf.text = ubicationP
            //}
        }else {
        }
        
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                // handle no location found
                return
            }
            self.lat = Float(location.coordinate.latitude)
            self.long = Float(location.coordinate.longitude)
            
            
        }
        modalUbicationVC.dismiss(animated: true, completion: nil)
    }
    func modalMassageVC(_ modalMassageVC: ModalMassagesVC, didFinishWithMassage massage: Array<Any>) {
        print(massage)
        massageTF.text = massage as? String
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
    @objc func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
    }
}
