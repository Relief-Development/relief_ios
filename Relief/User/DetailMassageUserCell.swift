//
//  DetailMassageUserCell.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//
//
import UIKit

class DetailMassageUserCell: UITableViewCell {
    
    static let identifier = "UserForSearchMassageIdentifier"
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
        
        for tag in (1 ... 5) {
            let starButton = (self.viewWithTag(tag) as! UIButton)
            starButton.isHighlighted = false
        }
        
        if var valoration = Float(user.media ?? "0") {
            valoration = round(valoration)
            
            if valoration > 0 {
                for tag in (1 ... Int(valoration)) {
                    if let starButton = (self.viewWithTag(tag) as? UIButton) {
                        starButton.isHighlighted = true
                    }
                }
            }
        }
    }
}
