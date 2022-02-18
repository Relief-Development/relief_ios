//
//  CreateAppointmentVC.swift
//  Relief
//
//  Created by Tatiana López Tchalián on 7/2/22.
//

import UIKit
import EventKit

class CreateAppointmentVC: UIViewController, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
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
        eventTF.delegate = self
        descriptionTF.delegate = self
        overrideUserInterfaceStyle = .light
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
                          DispatchQueue.main.async {
                              
                          
                              if (granted) && (error == nil)

                              {
                                let date = self.timePicker.date
                                let calendar = Calendar.current
                                let comp = calendar.dateComponents([.hour, .minute], from: date)
                                let hour = comp.hour
                                let minute = comp.minute
                            
                                let date2 = self.datePicker.date
                                let comp2 = calendar.dateComponents([.month, .year, .day], from: date2)
                                let day = comp2.day
                                let month = comp2.month
                                let year = comp2.year

                                var dateComponents = DateComponents()
                                dateComponents.year = year
                                dateComponents.month = month
                                dateComponents.day = day
                                dateComponents.hour = hour
                                dateComponents.minute = minute
                                  
                                
                                
                                let startDate = Calendar.current.date(from: dateComponents)

                                  let endDate = startDate?.addingTimeInterval(3600)
                                
                                 let event:EKEvent = EKEvent(eventStore: eventStore)
                                  event.title = self.eventTF.text
                                  event.startDate = startDate
                                  event.endDate = endDate
                                  event.notes = self.descriptionTF.text
                                  event.calendar = eventStore.defaultCalendarForNewEvents

                                  do {
                                       try eventStore.save(event, span: .thisEvent)
                                  } catch let error as NSError {
                                      print(error)

                                  }


                              } else {
                              }
                          }
                      }
        let alertController = UIAlertController(title: "Su cita ha sido agregada al calendario", message: nil, preferredStyle: .alert)
        alertController.view.tintColor = UIColor(named: "massage")

        
        
        let aceptar = UIAlertAction(title: "Aceptar", style: .cancel  , handler: {(action) in
            
        })
        alertController.addAction(aceptar)

        self.present(alertController, animated: true, completion: nil)
    }
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
