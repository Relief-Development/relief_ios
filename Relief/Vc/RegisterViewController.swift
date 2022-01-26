//
//  RegisterViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 25/1/22.
//

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet var segmentregister: UISegmentedControl?
    let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
    }
    @IBAction func buttonLoginTapped(){
        if let homeuser = mainstoryboard.instantiateViewController(withIdentifier: "homeuser") as? HomeViewController{
            view.window?.rootViewController = homeuser
        }
        
    }
    @IBAction func buttonToLoginTapped(){
        if let login = mainstoryboard.instantiateViewController(withIdentifier: "login") as? RegisterViewController{
            view.window?.rootViewController = login
        }
        
    }
}
