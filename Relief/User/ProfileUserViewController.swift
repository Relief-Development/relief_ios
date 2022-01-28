//
//  ProfileUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 24/1/22.
//

import UIKit

class ProfileUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModalProfileUserVCDelegate {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserCellIdentifier", for: indexPath)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenSettingsUserModal" {
            if let settingsVC = segue.destination as? ModalProfileUserVC {
                settingsVC.delegate = self
            }
        }
    }
    
    func mustGoPolitics() {
        if let politics = storyboard?.instantiateViewController(withIdentifier: "PoliticUserVc") {
            politics.modalPresentationStyle = .fullScreen
            self.present(politics, animated: true, completion: nil)
        }
    }
    
    func mustGoLegal() {
        if let legal = storyboard?.instantiateViewController(withIdentifier: "LegalUserVc"){
            legal.modalPresentationStyle = .fullScreen
            self.present(legal, animated: true, completion: nil)
        }
    }
}
