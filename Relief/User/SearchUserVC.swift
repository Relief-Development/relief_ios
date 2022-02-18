//
//  SearchUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit

class SearchUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextSearchView: UIView!
    var searchTutorial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Búsqueda"
        tutorialTextSearchView.layer.cornerRadius = 30
        if let value = UserDefaults.standard.object(forKey: "Searchtv") as? Bool{
            searchTutorial = value
        }
        if (searchTutorial == false){
            tutorialView.isHidden = true
        }
        overrideUserInterfaceStyle = .light
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUserMassageCellIdentifier", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailMassage = storyboard?.instantiateViewController(withIdentifier: "DetailMassageSearchUser") as? DetailMassageSearchUserVC{
            navigationController?.pushViewController(detailMassage, animated: true)
        }
    }
    
    @IBAction func closeTapped() {
        searchTutorial = false
        let name = searchTutorial
        UserDefaults.standard.set(name, forKey: "Searchtv")
        tutorialView.isHidden = true
    }
}
