//
//  HomeRecommendedUserCell.swift
//  Relief
//
//  Created by Alejandro Botana on 26/3/22.
//

import UIKit

class HomeRecommendedUserCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton?
    @IBOutlet var heartButton: UIButton?
    @IBOutlet var imageProfile: UIImageView!
    
    var user:User? {
        didSet{renderUI()}
    }
    var response: Response?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
        overrideUserInterfaceStyle = .light
        
        for tag in (1 ... 5) {
            let starButton = (self.viewWithTag(tag) as! UIButton)
            starButton.isHighlighted = false
        }
        
        if var valoration = Float(user?.media ?? "0") {
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
    func configureButton(){
        let imageHeart = UIImage(named: "ic_favoritoInactivo")
        let imageHeartFilled = UIImage(named: "ic_favoritoActivo")
        heartButton?.setImage(imageHeart, for: .normal)
        heartButton?.setImage(imageHeartFilled, for: .selected)
    }
}
