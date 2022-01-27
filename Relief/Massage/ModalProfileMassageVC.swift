//
//  ModalProfileMassageVC.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 27/1/22.
//

import UIKit

class ModalProfileMassageVC : ViewController{
    
    @IBOutlet var buttonexit: UIButton?
    @IBOutlet var modalView: UIView?
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalView?.layer.cornerRadius = 20
        self.modalView?.layer.borderColor = UIColor(named: "massage")?.cgColor
        self.modalView?.layer.borderWidth = 1
        
    }
    
    @IBAction func closeVC2(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
   @IBAction func goPolitics(_ sender: Any){
        if let politics = storyboard?.instantiateViewController(withIdentifier: "PoliticMassageVc"){
            politics.modalPresentationStyle = .fullScreen
            self.present(politics, animated: true, completion: nil)
        }
    }
    
    @IBAction func goLegal(_ sender: Any){
         if let legal = storyboard?.instantiateViewController(withIdentifier: "LegalMassageVc"){
             legal.modalPresentationStyle = .fullScreen
             self.present(legal, animated: true, completion: nil)
         }
     }
    @IBAction func buttonToLoginTapped(_ sender: Any){
        if let login = storyboard?.instantiateViewController(withIdentifier: "Login"){
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: true, completion: nil)
        }
        
    }
       
}
