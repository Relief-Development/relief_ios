//
//  ModalProfileUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 26/1/22.
//

import UIKit

protocol ModalProfileUserVCDelegate {
    func mustGoPolitics()
    func mustGoLegal()
}

class ModalProfileUserVC : ViewController{
    
    var delegate: ModalProfileUserVCDelegate?
    
    @IBOutlet var buttonexit: UIButton?
    @IBOutlet var modalView: UIView?
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalView?.layer.cornerRadius = 20
        self.modalView?.layer.borderColor = UIColor(named: "user")?.cgColor
        self.modalView?.layer.borderWidth = 1
        overrideUserInterfaceStyle = .light
        
    }
    
    @IBAction func closeVC2(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
   @IBAction func goPolitics(_ sender: Any) {
       self.dismiss(animated: true) {
           self.delegate?.mustGoPolitics()
       }
    }
    
    @IBAction func goLegal(_ sender: Any){
        self.dismiss(animated: true) {
            self.delegate?.mustGoLegal()
        }
     }
    @IBAction func buttonToLoginTapped(_ sender: Any){
        if let login = storyboard?.instantiateViewController(withIdentifier: "Login"){
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: true, completion: nil)
        }
        let role = ""
        UserDefaults.standard.set(role, forKey: "role")
        
    }
    @IBAction func resetTutorial(){
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "TutorialUser1"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
    }
       
}
