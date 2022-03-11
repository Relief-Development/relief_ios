//
//  EditUserProfileVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit
import AVFoundation

class EditUserProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var nameTf: UITextField!
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var passwordTf: UITextField!
    @IBOutlet var rpasswordTf: UITextField!
    @IBOutlet var addressTf: UITextField!


    let picker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.layer.borderColor = UIColor(named: "user")?.cgColor
        imageProfile.layer.borderWidth = 5
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        overrideUserInterfaceStyle = .light
       
    }
    @IBAction func buttonToProfileTapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let imageP = UserDefaults.standard.object(forKey: "image") as? String{
            let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
            var decodedimage = UIImage(data: decodedData as! Data)
            print(decodedimage)
            imageProfile.image = decodedimage as! UIImage
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
        let alertController = UIAlertController(title: nil, message: "Sus datos se han guardado", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Continuar", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
        
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
//        print(" ")
//        print(" ")
//        print(" ")
//        print(" ")
//        print(" ")
//        print("ESTA ES LA IMAGEN")
//        print(" ")
//        print(" ")
//        print(" ")
        
        
        let params: [String: Any] = [
            "image" : convertImageToBase64(image: image)
        ]
//        print(params)
    }
    func convertImageToBase64(image: UIImage) -> String{
        let imageData = image.jpegData(compressionQuality: 0.6)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
    }
    let imageStringData = convertImageToBase64(image: )
    
}
