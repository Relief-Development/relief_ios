//
//  ModalMassagesVc.swift
//  Relief
//
//  Created by Alejandro Botana on 18/3/22.
//

import UIKit

protocol ModalMassagesVCDelegate {
    func modalMassageVC(_ modalMassageVC: ModalMassagesVC, didFinishWithMassage massage: Array<Any>)
}

class ModalMassagesVC : ViewController{
    
    var delegate: ModalMassagesVCDelegate?
    
    @IBOutlet var buttonexit: UIButton?
    @IBOutlet var modalView: UIView?
    @IBOutlet var switch1: UISwitch?
    @IBOutlet var switch2: UISwitch?
    @IBOutlet var switch3: UISwitch?
    @IBOutlet var switch4: UISwitch?
    @IBOutlet var switch5: UISwitch?
    @IBOutlet var switch6: UISwitch?


    var massages: Array = [Int]();


    
    
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
        if switch1?.isOn == true {
            let switchM1 = 1
            massages.append(switchM1)
        }
        if switch2?.isOn == true {
            let switchM2 = 2
            massages.append(switchM2)
        }
        if switch3?.isOn == true {
            let switchM3 = 3
            massages.append(switchM3)
        }
        if switch4?.isOn == true {
            let switchM4 = 4
            massages.append(switchM4)
        }
        if switch5?.isOn == true {
            let switchM5 = 5
            massages.append(switchM5)
        }
        if switch6?.isOn == true {
            let switchM6 = 6
            massages.append(switchM6)
        }
        print(massages)
        UserDefaults.standard.set(massages, forKey: "Massage")
        delegate?.modalMassageVC(self, didFinishWithMassage: massages )
        self.dismiss(animated: true, completion: nil)
        print(UserDefaults.standard.set(massages, forKey: "Massage"))
        massages = []
    }
    
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }
       
}
