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
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView?
    @IBOutlet var noDataView: UIView!

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
        overrideUserInterfaceStyle = .light
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.massages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchUserMassageCellIdentifier", for: indexPath) as? SearchUserMassageCell{
            cell.massage = response?.massages?[indexPath.row]
            return cell
            
        }else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailMassage = storyboard?.instantiateViewController(withIdentifier: "DetailMassageSearchUser") as? DetailMassageSearchUserVC{
            detailMassage.massage = response?.massages?[indexPath.row]
            navigationController?.pushViewController(detailMassage, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
}
