//
//  ProfileMassageVC.swift
//  Relief
//
//  Created by Alejandro Botana on 26/1/22.
//

import UIKit

class ProfileMassageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalProfileMassageVCDelegate {
    
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextHomeView: UIView!
    var profileTutorialM = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMassageCellIdentifier", for: indexPath)
        return cell
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialTextHomeView.layer.cornerRadius = 30
        if let value = UserDefaults.standard.object(forKey: "ProfiletvM") as? Bool{
            profileTutorialM = value
        }
        if (profileTutorialM == false){
            tutorialView.isHidden = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenSettingsMassageModal" {
            if let settingsVC = segue.destination as? ModalProfileMassageVC {
                settingsVC.delegate = self
            }
        }
    }
    
    func mustGoPoliticsMassage() {
        if let politics = storyboard?.instantiateViewController(withIdentifier: "PoliticMassageVc") {
            politics.modalPresentationStyle = .fullScreen
            self.present(politics, animated: true, completion: nil)
        }
    }
    
    func mustGoLegalMassage() {
        if let legal = storyboard?.instantiateViewController(withIdentifier: "LegalMassageVc"){
            legal.modalPresentationStyle = .fullScreen
            self.present(legal, animated: true, completion: nil)
        }
    }
    @IBAction func closeTapped() {
        profileTutorialM = false
        let name = profileTutorialM
        UserDefaults.standard.set(name, forKey: "ProfiletvM")
        tutorialView.isHidden = true
    }
    @IBAction func editProfileTapped() {
        if let editprofile = storyboard?.instantiateViewController(withIdentifier: "EditProfileMassage"){
            editprofile.modalPresentationStyle = .fullScreen
            self.present(editprofile, animated: true, completion: nil)
        }
    }

}
