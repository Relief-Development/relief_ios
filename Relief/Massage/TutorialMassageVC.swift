//
//  TutorialMassageVC.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 3/2/22.
//

import UIKit

class TutorialMassageVC: UIViewController {
    
    @IBOutlet var tutorialMassageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialMassageView.layer.cornerRadius = 30
    }
   
    @IBAction func buttonMassageTapped(_ sender: Any){
        if let homemassage = storyboard?.instantiateViewController(withIdentifier: "HomeMassage"){
            homemassage.modalPresentationStyle = .fullScreen
            self.present(homemassage, animated: true, completion: nil)
        }
        
    }
}




