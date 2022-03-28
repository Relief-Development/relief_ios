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
    
    private var description2: String? = ""
    var response: Response?
    
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
        if descriptionTF.text == ""{
            descriptionTF.placeholder = "Introduce una descripcion"
        }else{
            if(indice == 0){
                descriptionTF.text = "\(description2 ?? "")"
            }else{
                descriptionTF.text = "\(massages[row].pick) - \(description2 ?? "")"
            }
        }
    }
    
    @IBAction func addtocalendar(){
        
        let alertController = UIAlertController(title: "Seleccione su opcion de guardado", message: nil, preferredStyle: .alert)
        alertController.view.tintColor = UIColor(named: "massage")
        
        
        
        let guardar = UIAlertAction(title: "Guardar", style: .default  , handler: {(action) in
            self.registerAppointments()
            self.dismiss(animated: true, completion: nil)
        })
        let calendar = UIAlertAction(title: "Guardar y añadir al calendario", style: .default  , handler: {(action) in
            let eventStore:EKEventStore = EKEventStore()
            self.registerAppointments()
            
            eventStore.requestAccess(to: .event) { (granted, error) in
                DispatchQueue.main.async {
                    
                    
                    if (granted) && (error == nil)
                        
                    { let date = self.timePicker.date
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
        description2 = textField.text
        return true
    }
    func registerAppointments(){
        
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
        
        //        if let anyo = year as? String {
        //            var year2 = anyo
        //            let dateSend = "\(year2)-\(month ?? 0)-\(day ?? 0)"
        //        }
        let dateSend = "\(year ?? 0)-\(month ?? 0)-\(day ?? 0)"
        let timeSend = "\(hour ?? 0):\(minute ?? 0)"
        let params2: [String: Any] = [
            "description": descriptionTF.text ?? "",
            "date": dateSend ,
            "time" : timeSend ,
            "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""
        ]
        
        DataMapper.shared.registerAppointments(params: params2) { response in
            if(response == nil){
                DispatchQueue.main.async {
                    self.showAlert(title: "Error en la conexion")
                }
            }else{
                
                DispatchQueue.main.async {
                    self.response = response
                    if(response?.status == 0){
                        //error
                    }else if response?.status == 1{
                        
                    }else if response?.status == 2{
                        self.showAlert(title: (response?.msg)!)
                    }else if response?.status == 3{
                        self.showAlert(title: (response?.msg)!)
                    }
                }
            }
        }
    }
    
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
