//
//  ModalProfileMassageVC.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 27/1/22.
//

import UIKit

protocol ModalProfileMassageVCDelegate {
    func mustGoPoliticsMassage()
    func mustGoLegalMassage()
}

class ModalProfileMassageVC : ViewController{
    
    var delegate: ModalProfileMassageVCDelegate?
    
    @IBOutlet var buttonexit: UIButton?
    @IBOutlet var modalView: UIView?
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalView?.layer.cornerRadius = 20
        self.modalView?.layer.borderColor = UIColor(named: "massage")?.cgColor
        self.modalView?.layer.borderWidth = 1
        overrideUserInterfaceStyle = .light
    }
    
    @IBAction func closeVC2(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goPolitics(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.mustGoPoliticsMassage()
        }
     }
     
     @IBAction func goLegal(_ sender: Any){
         self.dismiss(animated: true) {
             self.delegate?.mustGoLegalMassage()
         }
      }
    @IBAction func buttonToLoginTapped(_ sender: Any){
        if let login = storyboard?.instantiateViewController(withIdentifier: "Login"){
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func resetTutorial(){
        if let homemassage = storyboard?.instantiateViewController(withIdentifier: "TutorialMassage1"){
            homemassage.modalPresentationStyle = .fullScreen
            self.present(homemassage, animated: true, completion: nil)
        }
    }
       
}
