//
//  HomeViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 20/1/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet var addDateButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var todayDatesView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var firstDateButton: UIButton!
    @IBOutlet var secondDateButton: UIButton!
    @IBOutlet var thirdDateButton: UIButton!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var calendarButton: UIButton!
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextHomeView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "massage_light")
        self.navigationItem.title = "Citas"
        tutorialTextHomeView.layer.cornerRadius = 30

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMassageCellId", for: indexPath)
        return cell
    }

    @IBAction func addDates(_sender: Any) {
        if let detailAppointment = storyboard?.instantiateViewController(withIdentifier: "AppointmentID") as? CreateAppointmentVC{
            navigationController?.pushViewController(detailAppointment, animated: true)
        }
    }
    
    @IBAction func goToCalendar(_sender: Any) {
        guard let url = URL(string: "calshow://") else {
            print("No tienes el calendario")
            return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    @IBAction func closeTapped() {
        tutorialView.isHidden = true
    }
    

}



