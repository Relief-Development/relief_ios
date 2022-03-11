//
//  EditProfileMassageVC.swift
//  Relief
//
//  Created by Alejandro Botana on 8/2/22.
//

import UIKit
import CoreLocation

class EditProfileMassageVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, ModalUbicationMassageVCDelegate{
    
    
    
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var addressTf: UITextField!

    let picker = UIImagePickerController()
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.layer.borderColor = UIColor(named: "masssage")?.cgColor
        imageProfile.layer.borderWidth = 5
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        overrideUserInterfaceStyle = .light
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToUbicationSegue" {
            let ubicationVC = segue.destination as! ModalUbicationMassageVC
            ubicationVC.delegate = self
        }
    }
    @IBAction func buttonToProfileTapped(){
        self.dismiss(animated: true, completion: nil)
        
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
        
    }
    
    // MARK: - ModalUbicationVC delegate
    func modalUbicationVC(_ modalUbicationVC: ModalUbicationMassageVC, didFinishWithAddress address: String) {
        
        addressTf.text = address

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                // handle no location found
                return
            }
            let params: [String: Any] = [
                "lat" : location.coordinate.latitude,
                "long" : location.coordinate.longitude
                
            ]
            print(params)
        }
        modalUbicationVC.dismiss(animated: true, completion: nil)
    }
}
