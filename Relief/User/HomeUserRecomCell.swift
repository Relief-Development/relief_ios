//
//  HomeUserRecomCell.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 27/1/22.
//

import UIKit

class HomeUserRecomCell: UITableViewCell {
    
    static let identifierRecom = "HomeUserRecomCellId"
    static let identifierFav = "HomeUserFavCellId"
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var button: UIButton?
    @IBOutlet var heartButton: UIButton?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
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
}
