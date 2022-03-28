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
    @IBOutlet var nameL: UILabel!
    @IBOutlet var ubicationTV: UITextView!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noServicesView: UIView!
    @IBOutlet var tableView: UITableView!

    var response: Response?
    var profileTutorialM = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMassageCell2", for: indexPath) as? ProfileMassageCell{
            cell.user = response?.list?[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            return cell
            
            
        }else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        overrideUserInterfaceStyle = .light
    }
    override func viewWillAppear(_ animated: Bool) {
        self.noServicesView.isHidden = true
        self.spinnerView.isHidden = false
        if let nameP = UserDefaults.standard.object(forKey: "name") as? String{
            nameL.text = nameP
        }
        if let ubicationP = UserDefaults.standard.object(forKey: "address") as? String{
           // if ubicationP != ""{
                ubicationTV.text = ubicationP
            //}
        }
        if let imageP = UserDefaults.standard.object(forKey: "image") as? String{
            if imageP != ""{
                let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                var decodedimage = UIImage(data: decodedData as! Data)
                //print(decodedimage)
                imageProfile.image = decodedimage as! UIImage
               
            }else{
                imageProfile.image = UIImage(systemName: "person.circle.fill")
            }
            imageProfile.layer.borderColor = UIColor(named: "massage")?.cgColor
            imageProfile.layer.borderWidth = 5
            imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0
        }
        let params2: [String: Any] = [
            "id": UserDefaults.standard.object(forKey: "id") as? Int,
            "api_token": UserDefaults.standard.object(forKey: "token") as? String
        ]
        print(params2)
        DataMapper.shared.getServices(params: params2) { response in
            if(response == nil){
                DispatchQueue.main.async {
                        //print("LA RESPUESTA ES")
                        //print(response)
                        self.spinnerView.isHidden = true
                        self.noDataView.isHidden = false

                    }
                }else{
                        DispatchQueue.main.async {
                            self.response = response
                            self.spinnerView.isHidden = true
                            self.tableView.isHidden = false
                            self.tableView.reloadData()

                            
                            if(response?.status == 0){
                                //error
                            }else if response?.status == 1{
                                
                        }else if response?.status == 2{
                        }else if response?.status == 3{
                        }else if response?.status == 7 {
                            self.noServicesView.isHidden = false
                        }
                    }
                }
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
