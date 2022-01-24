//
//  ProfileUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 24/1/22.
//

import UIKit

class ProfileUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

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
}
