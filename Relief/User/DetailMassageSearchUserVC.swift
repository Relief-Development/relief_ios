//
//  DetailMassageSearchUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit

class DetailMassageSearchUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserForSearchMassageIdentifier", for: indexPath)
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Masajes relajantes"
    }
    

}

