//
//  PoliticUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 26/1/22.
//

import UIKit

class PoliticUserVC: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    @IBAction func buttonToProfileTapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
}
