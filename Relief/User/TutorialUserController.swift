//
//  TutorialUserController.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 3/2/22.
//

import UIKit

class TutorialUserController: UIViewController {
    
    @IBOutlet var tutorialView: UIView!
    var tutorial: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialView.layer.cornerRadius = 30
        overrideUserInterfaceStyle = .light
    }
   
    @IBAction func buttonUserTapped(_ sender: Any){
        if let homeuser = storyboard?.instantiateViewController(withIdentifier: "HomeUser"){
            homeuser.modalPresentationStyle = .fullScreen
            self.present(homeuser, animated: true, completion: nil)
        }
        
        let home = tutorial
        UserDefaults.standard.set(home, forKey: "Hometv")
        let search = tutorial
        UserDefaults.standard.set(search, forKey: "Searchtv")
        let map = tutorial
        UserDefaults.standard.set(map, forKey: "Maptv")
        let profile = tutorial
        UserDefaults.standard.set(profile, forKey: "Profiletv")
    }
}
