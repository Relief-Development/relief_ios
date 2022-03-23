//
//  MassageProfileFromUserVC.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 6/2/22.
//

import UIKit

class MassageProfileFromUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableViewVal: UITableView!
    @IBOutlet var descriptionTv: UITextView!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var nameProfile: UILabel!

    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
        overrideUserInterfaceStyle = .light
        
        if let name = self.user?.name{
            self.nameProfile.text = name
        }
        if let description = self.user?.description{
            self.descriptionTv!.text = description
        }
        if let imageP = self.user?.image{
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
    @IBAction func callTherapist(){
        let number = Int(self.user?.phone_number ?? "")
        guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else { return }
         UIApplication.shared.openURL(url)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserCell", for: indexPath)
        return cell
    }
    @IBAction func buttonToDetailTapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
   
}
