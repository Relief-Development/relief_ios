//
//  RecoverPassViewController.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 26/1/22.
//

import UIKit

class RecoverPassViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var recoveryEmailTF: UITextField?
    @IBOutlet var recoveryBtn: UIButton?
    @IBOutlet var noDataView: UIView!
    
    var response: Response?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recoveryBtn?.layer.cornerRadius = 6
        self.recoveryEmailTF?.delegate = self
        self.recoveryEmailTF?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named:"user_light")!] )
        overrideUserInterfaceStyle = .light
        
    }
    
    @IBAction func buttonRecoverTapped(_ sender: Any){
        if(recoveryEmailTF?.text == "" ){
            self.showAlert(title: "Rellena los campos")
        }else{
            let params: [String: Any] = [
                "email": recoveryEmailTF?.text ?? ""
            ]
            print(params)

            DataMapper.shared.recoverPass(params: params, completion: { response in

                if(response == nil){
                    DispatchQueue.main.async {
                        print("LA RESPUESTA ES")
                        print(response)
                        self.noDataView.isHidden = false
                        self.showAlert(title: "Error en la conexion")
                        self.recoveryEmailTF?.text = ""
                    }
                }else{
                    DispatchQueue.main.async {

                        self.response = response

                        if(response?.status == 0){
                            self.showAlert(title: (response?.msg)!)
                        }else if response?.status == 1{
                            self.showAlert(title: (response?.msg)!)
                        }else if response?.status == 2{
                            self.showAlert(title: (response?.msg)!)
                        }else if response?.status == 3{
                            self.showAlert(title: (response?.msg)!)
                        }                    }


                }
            })


            }
        }
    
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.noDataView.isHidden = true
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }


    
}
