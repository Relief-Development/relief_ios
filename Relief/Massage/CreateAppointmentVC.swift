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

    private var userName: String? = ""
    
    private var indice: Int? = 0
struct Massage {
    var pick: String
}

let massages: [Massage] = [Massage(pick: "Seleccione masaje"),Massage(pick: "Masaje relajante"),Massage(pick: "Masaje facial"),Massage(pick: "Masaje terapéutico"),Massage(pick: "Masaje sueco")]

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
    let massage = massages[row].pick
    return massage
}

func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return massages.count
}
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    indice = row
    if eventTF.text == ""{
        eventTF.placeholder = "Introduce un nombre"
    }else{
        if(indice == 0){
            eventTF.text = "\(userName ?? "")"
        }else{
            eventTF.text = "\(userName ?? "") - \(massages[row].pick)"
        }
    }
}

@IBAction func addtocalendar(){
    
    let alertController = UIAlertController(title: "Seleccione su opcion de guardado", message: nil, preferredStyle: .alert)
    alertController.view.tintColor = UIColor(named: "massage")

    
    
    let guardar = UIAlertAction(title: "Guardar", style: .default  , handler: {(action) in
        
        self.dismiss(animated: true, completion: nil)
    })
    let calendar = UIAlertAction(title: "Guardar y añadir al calendario", style: .default  , handler: {(action) in
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
                                      self.dismiss(animated: true, completion: nil)
                                  } catch let error as NSError {
                                      print(error)

                                  }


                              } else {
                              }
                          }
                      }
    })
    alertController.addAction(guardar)
    alertController.addAction(calendar)


    self.present(alertController, animated: true, completion: nil)
}
@objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    userName = textField.text
    return true
}
}
