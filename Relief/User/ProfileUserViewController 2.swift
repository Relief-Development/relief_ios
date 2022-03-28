//
//  ProfileUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 24/1/22.
//

import UIKit

class ProfileUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalProfileUserVCDelegate {
    
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextProfileView: UIView!
    @IBOutlet var nameL: UILabel!
    @IBOutlet var createdTV: UITextView!
    @IBOutlet var imageProfile: UIImageView!
    
    var profileTutorial = true

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserCellIdentifier", for: indexPath)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialTextProfileView.layer.cornerRadius = 30
        
        if let value = UserDefaults.standard.object(forKey: "Profiletv") as? Bool{
            profileTutorial = value
        }
        if (profileTutorial == false){
            tutorialView.isHidden = true
        }
        overrideUserInterfaceStyle = .light
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let nameP = UserDefaults.standard.object(forKey: "name") as? String{
            nameL.text = nameP
        }
        if let createdP = UserDefaults.standard.object(forKey: "created") as? String{
            createdTV.text = createdP
        }
        if let imageP = UserDefaults.standard.object(forKey: "image") as? String{
            if imageP != ""{
                let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                var decodedimage = UIImage(data: decodedData as! Data)
                //print(decodedimage)
                imageProfile.image = decodedimage as! UIImage
               
            }else{
                imageProfile.image = UIImage(systemName: "person.circle.fill")
                imageProfile.tintColor = UIColor(named: "gray")
            }
            imageProfile.layer.borderColor = UIColor(named: "user")?.cgColor
            imageProfile.layer.borderWidth = 5
            imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenSettingsUserModal" {
            if let settingsVC = segue.destination as? ModalProfileUserVC {
                settingsVC.delegate = self
            }
        }
    }
    
    func mustGoPolitics() {
        if let politics = storyboard?.instantiateViewController(withIdentifier: "PoliticUserVc") {
            politics.modalPresentationStyle = .fullScreen
            self.present(politics, animated: true, completion: nil)
        }
    }
    
    func mustGoLegal() {
        if let legal = storyboard?.instantiateViewController(withIdentifier: "LegalUserVc"){
            legal.modalPresentationStyle = .fullScreen
            self.present(legal, animated: true, completion: nil)
        }
    }
    @IBAction func editProfileTapped() {
        if let editprofile = storyboard?.instantiateViewController(withIdentifier: "EditProfileUser"){
            editprofile.modalPresentationStyle = .fullScreen
            self.present(editprofile, animated: true, completion: nil)
        }
    }
    
    @IBAction func closeTapped() {
        profileTutorial = false
        let name = profileTutorial
        UserDefaults.standard.set(name, forKey: "Profiletv")
        tutorialView.isHidden = true
    }
}
