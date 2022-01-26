//
//  LegalUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 26/1/22.
//

import UIKit

class LegalUserVC: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func buttonToProfileTapped(){
        if let profile = storyboard?.instantiateViewController(withIdentifier: "ProfileUser"){
            profile.modalPresentationStyle = .fullScreen
            self.present(profile, animated: true, completion: nil)
        }
        
    }
}
