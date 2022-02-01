//
//  HomeUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 20/1/22.
//
import UIKit

class HomeUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var homecell: HomeUserRecomCell?
    @IBOutlet var tableViewRec: UITableView!
    @IBOutlet var tableViewFav: UITableView!
    @IBOutlet var favView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
        homecell?.button?.setTitle(" ", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableViewRec {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUserRecomCellId", for: indexPath)
            return cell
            
        } else if tableView == self.tableViewFav {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUserFavCellId", for: indexPath)
            return cell
        }
        
        return UITableViewCell()
    }
    
    @IBAction func favTapped() {
        if(favView.isHidden == true) {
            self.favView.isHidden = false
        }
        else {
            self.favView.isHidden = true
        }
    }
}

