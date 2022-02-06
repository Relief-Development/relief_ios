//
//  TutorialUserController.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 3/2/22.
//

import UIKit

class TutorialUserController: UIViewController {
    
    @IBOutlet var tutorialView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialView.layer.cornerRadius = 30
    }
   
    @IBAction func buttonUserTapped(_ sender: Any){
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
    }
}
