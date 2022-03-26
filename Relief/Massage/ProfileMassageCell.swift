//
//  ProfileMassageCell.swift
//  Relief
//
//  Created by Alejandro Botana on 26/1/22.
//

import UIKit

class ProfileMassageCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageProfile: UIImageView!

    
    
    var user:User? {
        didSet{renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    private func renderUI(){
        guard let user = user else {return}
        if let name = self.user?.name{
            self.nameLabel.text = name
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
}



