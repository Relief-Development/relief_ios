//
//  MassageProfileFromUserVC.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 6/2/22.
//

import UIKit

class MassageProfileFromUser: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableViewVal: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserCell", for: indexPath)
        return cell
    }
   
}
