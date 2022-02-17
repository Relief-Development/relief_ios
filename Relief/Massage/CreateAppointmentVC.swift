//
//  CreateAppointmentVC.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 7/2/22.
//

import UIKit
import EventKit

class CreateAppointmentVC: UIViewController, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate, UIPickerViewDataSource {
    
    @IBOutlet var servicePicker: UIPickerView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var eventTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!

    
    struct Massage {
        var pick: String
    }
    
    let massages: [Massage] = [Massage(pick: "Masaje relajante"),Massage(pick: "Masaje facial"),Massage(pick: "Masaje terapéutico"),Massage(pick: "Masaje sueco")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Agregar cita"
        servicePicker.dataSource = self
        servicePicker.delegate = self
        textFieldShouldReturn(eventTF)
        textFieldShouldReturn(descriptionTF)
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
    
    @IBAction func addtocalendar(){
        let eventStore:EKEventStore = EKEventStore()

                      eventStore.requestAccess(to: .event) { (granted, error) in

                          if (granted) && (error == nil)

                          {

                            var dateComponents = DateComponents()
                            dateComponents.year = 2022
                            dateComponents.month = 3
                            dateComponents.day = 12
                            dateComponents.hour = 10
                            dateComponents.minute = 00
                            
                            let startDate = Calendar.current.date(from: dateComponents)

                            dateComponents.hour = 11

                            let endDate = Calendar.current.date(from: dateComponents)
                            
                             let event:EKEvent = EKEvent(eventStore: eventStore)
                              event.title = self.eventTF.text
                              event.startDate = startDate
                              event.endDate = endDate
                              event.notes = self.descriptionTF.text
                              event.calendar = eventStore.defaultCalendarForNewEvents

                              do {
                                   try eventStore.save(event, span: .thisEvent)
                              } catch let error as NSError {

                              }


                          } else {
                          }
                      }
        let alertController = UIAlertController(title: "Su cita ha sido agregada al calendario", message: nil, preferredStyle: .alert)
        alertController.view.tintColor = UIColor(named: "massage")

        
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .cancel  , handler: {(action) in
            
        })
        alertController.addAction(aceptar)

        self.present(alertController, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
