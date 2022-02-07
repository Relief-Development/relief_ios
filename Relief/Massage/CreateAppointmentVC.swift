//
//  CreateAppointmentVC.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 7/2/22.
//

import UIKit

class CreateAppointmentVC: UIViewController, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate, UIPickerViewDataSource {
    
    @IBOutlet var servicePicker: UIPickerView!
    
    struct Massage {
        var pick: String
    }
    
    let massages: [Massage] = [Massage(pick: "Masaje relajante"),Massage(pick: "Masaje facial"),Massage(pick: "Masaje terapéutico"),Massage(pick: "Masaje sueco")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Agregar cita"
        servicePicker.dataSource = self
        servicePicker.delegate = self
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return massages[row].pick
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return massages.count
    }
}
