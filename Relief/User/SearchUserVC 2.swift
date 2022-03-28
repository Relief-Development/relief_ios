//
//  SearchUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit

class SearchUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextSearchView: UIView!
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var noDataView: UIView!
    
    var search = false
    
    var response: Response?
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
        searchBar.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.chargeMassages()
        search = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let search = searchText
        self.search = true
        self.spinnerView.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        
        let params2: [String: Any] = [
            "search": search
        ]
        print(params2)
        DataMapper.shared.search(params: params2) { response in
            print(response)
            if(response == nil){
                DispatchQueue.main.async {
                    //print("LA RESPUESTA ES")
                    //print(response)
                    self.spinnerView.isHidden = true
                    self.noDataView.isHidden = false
                    self.showAlert(title: "Error en la conexion")
                    
                }
            }else{
                DispatchQueue.main.async {
                    print("++++++++++++++++++++ \(self.response?.services?.count)")
                    self.response = response
                    self.spinnerView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    
                    
                    if(response?.status == 0){
                        //error
                    }else if response?.status == 1{
                        
                    }else if response?.status == 2{
                        self.showAlert(title: (response?.msg)!)
                    }else if response?.status == 3{
                        self.showAlert(title: (response?.msg)!)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        search = false
        chargeMassages()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search == false{
            return response?.massages?.count ?? 0
        }else{
            return response?.services?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if search == false{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUserMassageCellIdentifier", for: indexPath) as? SearchUserMassageCell{
                cell.massage = response?.massages?[indexPath.row]
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserForSearchMassageIdentifier", for: indexPath) as? DetailMassageUserCell{
                cell.user = response?.services?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if search == false{
            if let detailMassage = storyboard?.instantiateViewController(withIdentifier: "DetailMassageSearchUser") as? DetailMassageSearchUserVC{
                detailMassage.massage = response?.massages?[indexPath.row]
                navigationController?.pushViewController(detailMassage, animated: true)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            
            if let massageFromUser = storyboard?.instantiateViewController(withIdentifier: "MassageProfileFromUser") as? MassageProfileFromUserVC{
                massageFromUser.modalPresentationStyle = .fullScreen
                massageFromUser.user = response?.services?[indexPath.row]
                self.present(massageFromUser, animated: true, completion: nil)
                
            }
        }
        
    }
    
    @IBAction func closeTapped() {
        searchTutorial = false
        let name = searchTutorial
        UserDefaults.standard.set(name, forKey: "Searchtv")
        tutorialView.isHidden = true
    }
    
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func textSearchShouldReturn(_ searchBar: UISearchBar) -> Bool {
        self.view.endEditing(true)
    }
    func chargeMassages(){
        self.spinnerView.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        
        let params: [String: Any] = [
            "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""
        ]
        print(params)
        DataMapper.shared.list(params: params) { response in
            if(response == nil){
                DispatchQueue.main.async {
                    //print("LA RESPUESTA ES")
                    //print(response)
                    self.spinnerView.isHidden = true
                    self.noDataView.isHidden = false
                    self.showAlert(title: "Error en la conexion")
                    
                }
            }else{
                DispatchQueue.main.async {
                    self.response = response
                    self.spinnerView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    
                    
                    if(response?.status == 0){
                        //error
                    }else if response?.status == 1{
                        
                    }else if response?.status == 2{
                        self.showAlert(title: (response?.msg)!)
                    }else if response?.status == 3{
                        self.showAlert(title: (response?.msg)!)
                    }
                }
            }
        }
    }
}
