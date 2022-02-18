//
//  HomeUserRecomCell.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 27/1/22.
//

import UIKit

class HomeUserCell: UITableViewCell {
    
    static let identifierRecom = "HomeUserRecomCellId"
    static let identifierFav = "HomeUserFavCellId"
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton?
    @IBOutlet var heartButton: UIButton?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
        overrideUserInterfaceStyle = .light
    }
    
    func configureButton(){
        let imageHeart = UIImage(named: "ic_favoritoActivo")
        let imageHeartFilled = UIImage(named: "ic_favoritoInactivo")
        heartButton?.setImage(imageHeart, for: .normal)
        heartButton?.setImage(imageHeartFilled, for: .selected)
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        heartButton?.isSelected.toggle()
    }
    
    @IBAction func starButtonTapped(_ button: UIButton) {
        for tag in (1 ... 5) {
            let starButton = (self.viewWithTag(tag) as! UIButton)
            starButton.isHighlighted = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(1/120)) {
            let pushedTag = button.tag
            
            
            
            for tag in (1 ... pushedTag) {
                if let starButton = (self.viewWithTag(tag) as? UIButton) {
                    starButton.isHighlighted = true
                }
            }
        }
    }
}
