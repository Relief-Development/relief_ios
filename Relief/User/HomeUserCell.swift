//
//  HomeUserRecomCell.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 27/1/22.
//

import UIKit

class HomeUserCell: UITableViewCell {
    
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
    
    @IBAction func favButtonTapped(_ sender: Any) {
        heartButton?.isSelected.toggle()
        let params2: [String: Any] = [
            "therapist_id": String(self.user?.id ?? 0),
            "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""
        ]
        
        DataMapper.shared.addRemoveFavorites(params: params2) { response in
//            print(params2)
//            print(response)
            if(response == nil){
                DispatchQueue.main.async {
                   
                }
            }else{
                
                    DispatchQueue.main.async {
                        self.response = response
                        if(response?.status == 0){
                            //error
                        }else if response?.status == 1{
                            
                    }else if response?.status == 2{
                        
                    }else if response?.status == 3{
                        
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
        let imageHeart = UIImage(named: "ic_favoritoActivo")
        let imageHeartFilled = UIImage(named: "ic_favoritoInactivo")
        heartButton?.setImage(imageHeart, for: .normal)
        heartButton?.setImage(imageHeartFilled, for: .selected)
    }
}
