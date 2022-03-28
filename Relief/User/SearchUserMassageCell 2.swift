//
//  SearchUserMassageCell.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit

class SearchUserMassageCell: UITableViewCell {
    
    static let identifier = "SearchUserMassageCellIdentifier"
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var massageImage: UIImageView!
       
        
        var massage:Massage? {
            didSet{renderUI()}
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
        
        }
        
        private func renderUI(){
            guard let massage = massage else {return}
            if let name = self.massage?.name{
                self.nameLabel.text = name
            }
            if let imageP = self.massage?.image{
                if imageP != ""{
                    let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                    var decodedimage = UIImage(data: decodedData as! Data)
                    //print(decodedimage)
                    massageImage.image = decodedimage as! UIImage
                    massageImage.layer.cornerRadius = massageImage.frame.height / 2.0

                   
                }else{
                    massageImage.image = UIImage(systemName: "person.circle.fill")
                    massageImage.tintColor = UIColor(named: "gray")

                }
            }
        }
}
