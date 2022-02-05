//
//  HomeUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 20/1/22.
//
import UIKit

class HomeUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var homecell: HomeUserCell?
    @IBOutlet var tableViewRec: UITableView!
    @IBOutlet var tableViewFav: UITableView!
    @IBOutlet var emptyFavView: UIView!
    @IBOutlet var recomendedView: UIView!
    @IBOutlet var favView: UIView!
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextHomeView: UIView!
    @IBOutlet var segmentedHome: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
        homecell?.button?.setTitle(" ", for: .normal)
        tutorialTextHomeView.layer.cornerRadius = 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
        if(emptyFavView.isHidden == false) {
            self.emptyFavView.isHidden = true
            self.favView.isHidden = false
        }
    }
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        if segmentedHome.selectedSegmentIndex == 1 {
            self.recomendedView.isHidden = true
            self.emptyFavView.isHidden = false
        }else if segmentedHome.selectedSegmentIndex == 0{
            self.recomendedView.isHidden = false
            self.favView.isHidden = true
        }
    }
        
    @IBAction func closeTapped() {
        tutorialView.isHidden = true
    }
    
}

