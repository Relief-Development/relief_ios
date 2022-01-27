//
//  HomeUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 20/1/22.
//
import UIKit

class HomeUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var homecell: HomeUserRecomCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
        homecell?.burron?.setTitle(" ", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUserRecomCellId", for: indexPath)
        return cell
    }
}

