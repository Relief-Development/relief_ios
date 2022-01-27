//
//  LegalMassageVC.swift
//  Relief
//
//  Created by Alejandro Botana on 26/1/22.
//

import UIKit

class LegalMassageVC: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func buttonToProfileTapped(){
        if let profile = storyboard?.instantiateViewController(withIdentifier: "ProfileMassage"){
            profile.modalPresentationStyle = .fullScreen
            self.present(profile, animated: true, completion: nil)
        }
        
    }
}
