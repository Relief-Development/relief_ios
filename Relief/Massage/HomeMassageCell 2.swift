//
//  HomeMassageCell.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 7/2/22.
//

import UIKit

class HomeMassageCell: UITableViewCell {

    static let identifier = "HomeMassageCellId"
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionTV: UITextView!
    @IBOutlet var timeBtn: UIButton!

    var appointment:Appointment? {
        didSet{renderUI()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    private func renderUI(){
        guard let appointment = appointment else {return}
        if let description = self.appointment?.description{
            self.descriptionTV.text = description
        }
        if let time = self.appointment?.time{
            self.timeBtn.setTitle(time, for: .normal)
        }
        if let date = self.appointment?.date{
            self.dateLabel.text = date
        }
    }
    
}

    
   
