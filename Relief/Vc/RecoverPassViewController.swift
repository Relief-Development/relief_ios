//
//  RecoverPassViewController.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 26/1/22.
//

import UIKit

class RecoverPassViewController: UIViewController {
    
    @IBOutlet var recoveryEmailTextField: UITextField?
    @IBOutlet var recoveryBtn: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoveryBtn?.layer.cornerRadius = 6
        self.recoveryEmailTextField?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named:"user_light")!] )
        overrideUserInterfaceStyle = .light
        
    }
    
//    @IBAction func buttonRecoverTapped(_ sender: Any){
//        if(recoveryEmailTF?.text == "" ){
//            self.Alert(title: "Rellena los campos")
//        }else{
//            let params: [String: Any] = [
//                "email": recoveryEmailTF?.text ?? ""
//            ]
//            print(params)
//
//            DataMapper.shared.recoverPass(params: params, completion: { response in
//
//                if(response == nil){
//                    DispatchQueue.main.async {
//                        print("LA RESPUESTA ES")
//                        print(response)
//                        self.noDataView.isHidden = false
//                        self.Alert(title: "Error en la conexion")
//                        self.recoveryEmailTF?.text = ""
//                    }
//                }else{
//                    DispatchQueue.main.async {
//
//                        self.response = response
//
//                        if(response?.status == 0){
//                            self.Alert(title: (response?.msg)!)
//                        }else if response?.status == 1{
//                            self.Alert(title: (response?.msg)!)
//                        }
//                    }
//
//
//                }
//            })
//
//
//            }
//        }
    
//    @IBAction func buttonMapTapped(_ sender: Any){
//        if let map = storyboard?.instantiateViewController(withIdentifier: "MassageProfileFromUser"){
//            map.modalPresentationStyle = .fullScreen
//            self.present(map, animated: true, completion: nil)
//        }
//
//    }
    
}
