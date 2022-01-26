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
    @IBAction func buttonLoginTapped(_ sender: Any){
        if segmentregister?.selectedSegmentIndex == 0{
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
        }else {
            if let homemassage = storyboard?.instantiateViewController(withIdentifier: "HomeMassage"){
                homemassage.modalPresentationStyle = .fullScreen
                self.present(homemassage, animated: true, completion: nil)
            }
        }
    }
    @IBAction func buttonToLoginTapped(_ sender: Any){
        if let login = storyboard?.instantiateViewController(withIdentifier: "Login"){
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: true, completion: nil)
        }
        
    }
}
