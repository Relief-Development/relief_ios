//
//  ModalUbicationMassageVC.swift
//  Relief
//
//  Created by Alejandro Botana on 10/3/22.
//

import UIKit

protocol ModalUbicationMassageVCDelegate {
    func modalUbicationVC(_ modalUbicationVC: ModalUbicationMassageVC, didFinishWithAddress address: String)
}

class ModalUbicationMassageVC : ViewController{
    
    var delegate: ModalUbicationMassageVCDelegate?
    
    @IBOutlet var buttonexit: UIButton?
    @IBOutlet var modalView: UIView?
    @IBOutlet var streetTf: UITextField!
    @IBOutlet var numberTf: UITextField!
    @IBOutlet var cityTf: UITextField!
    @IBOutlet var floorTf: UITextField!
    @IBOutlet var postalCodeTf: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalView?.layer.cornerRadius = 20
        self.modalView?.layer.borderColor = UIColor(named: "massage")?.cgColor
        self.modalView?.layer.borderWidth = 1
        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func closeVC2(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveTapped(_ sender: Any) {
        guard let street = streetTf.text, !street.isEmpty else {
            self.showAlert(title: "Rellena el campo calle")
            return
        }
        guard let city = cityTf.text, !city.isEmpty else {
            self.showAlert(title: "Rellena el campo ciudad")
            return
        }
        guard let postalCode = postalCodeTf.text, !postalCode.isEmpty else {
            self.showAlert(title: "Rellena el campo codigo postal")
            return
        }
        guard let number = numberTf.text, !number.isEmpty else {
            self.showAlert(title: "Rellena el campo numero")
            return
        }
        guard let floor = floorTf.text, !floor.isEmpty else {
            self.showAlert(title: "Rellena el campo piso")
            return
        }
        
        
        let address = "\(street), \(number), \(city), \(postalCode)"
        let addressU =  "\(street), \(number), \(floor), \(city), \(postalCode)"
        UserDefaults.standard.set(addressU, forKey: "address")
        
        delegate?.modalUbicationVC(self, didFinishWithAddress: address)
    }
    
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }
       
}
