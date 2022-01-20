//
//  HomeUserViewController.swift
//  Relief
//
//  Created by Alejandro Botana on 20/1/22.
//
import UIKit

class HomeUserViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
    }
}

