//
//  DetailMassageSearchUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit

class DetailMassageSearchUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var massage:Massage?
    @IBOutlet var descriptionTv: UITextView!
    @IBOutlet var imageProfile: UIImageView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserForSearchMassageIdentifier", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let massageFromUser = storyboard?.instantiateViewController(withIdentifier: "MassageProfileFromUser") as? MassageProfileFromUserVC{
            massageFromUser.modalPresentationStyle = .fullScreen
            self.present(massageFromUser, animated: true, completion: nil)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Masajes relajantes"
        overrideUserInterfaceStyle = .light
        if let name = self.massage?.name{
            self.navigationItem.title = name
        }
        if let description = massage?.description{
            self.descriptionTv!.text = description
        }
        if let imageP = self.massage?.image{
            if imageP != ""{
                let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                var decodedimage = UIImage(data: decodedData as! Data)
                //print(decodedimage)
                imageProfile.image = decodedimage as! UIImage
                imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0

               
            }else{
                imageProfile.image = UIImage(systemName: "person.circle.fill")
                imageProfile.tintColor = UIColor(named: "gray")

            }
    }
    }

}


