//
//  HomeViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 20/1/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var todayDatesView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeBtn: UIButton!
    @IBOutlet var descriptionTV: UITextView!
    @IBOutlet var calendarButton: UIButton!
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextHomeView: UIView!
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var noServicesView: UIView!
    @IBOutlet var tableView: UITableView!
    var homeTutorialM = true
    
    var response: Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "massage_light")
        self.navigationItem.title = "Citas"
        tutorialTextHomeView.layer.cornerRadius = 30
        if let value = UserDefaults.standard.object(forKey: "HometvM") as? Bool{
            homeTutorialM = value
        }
        if (homeTutorialM == false){
            tutorialView.isHidden = true
        }
        overrideUserInterfaceStyle = .light
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.appointments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMassageCellId", for: indexPath) as? HomeMassageCell{
            cell.appointment = response?.appointments?[indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.spinnerView.isHidden = false
        let params2: [String: Any] = [
            "api_token": UserDefaults.standard.object(forKey: "token") as? String
        ]
        DataMapper.shared.getAppointments(params: params2) { response in
            if(response == nil){
                DispatchQueue.main.async {
                    //print("LA RESPUESTA ES")
                    //print(response)
                    self.spinnerView.isHidden = true
                    self.noDataView.isHidden = false
                    
                }
            }else{
                DispatchQueue.main.async {
                    self.response = response
                    self.spinnerView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    
                    
                    if(response?.status == 0){
                        //error
                    }else if response?.status == 1{
                        self.dateLabel.text = response?.appointments?[0].date
                        self.timeBtn.setTitle(response?.appointments?[0].time, for: .normal) 
                        self.descriptionTV.text = response?.appointments?[0].description

                    }else if response?.status == 2{
                    }else if response?.status == 3{
                    }else if response?.status == 7 {
                        self.noServicesView.isHidden = false
                    }
                }
            }
        }
    }
    
    
    @IBAction func goToCalendar(_sender: Any) {
        guard let url = URL(string: "calshow://") else {
            print("No tienes el calendario")
            return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @IBAction func closeTapped() {
        homeTutorialM = false
        let name = homeTutorialM
        UserDefaults.standard.set(name, forKey: "HometvM")
        tutorialView.isHidden = true
    }
    
    
}



