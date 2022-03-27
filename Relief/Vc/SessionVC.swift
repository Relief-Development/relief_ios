//
//  SessionVC.swift
//  Relief
//
//  Created by Alejandro Botana on 25/3/22.
//

import UIKit

class SessionVC: UIViewController{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let roll = UserDefaults.standard.object(forKey: "role") as? String{
            AppData.shared.role = roll
            print("Este es el role")
            print(roll)
        }
        
        let homeuser = self.storyboard?.instantiateViewController(withIdentifier: "HomeUser")
        let homemassage = self.storyboard?.instantiateViewController(withIdentifier: "HomeMassage")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if AppData.shared.role == "Usuario"{
                
                homeuser!.modalPresentationStyle = .fullScreen
                self.present(homeuser!, animated: true, completion: nil)
            }else if AppData.shared.role == "Masajista"{
                
                homemassage!.modalPresentationStyle = .fullScreen
                self.present(homemassage!, animated: true, completion: nil)
                
            }else {
                let login = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                login!.modalPresentationStyle = .fullScreen
                self.present(login!, animated: true, completion: nil)
            }
        }
    }
}
