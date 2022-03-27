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
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var noDataView: UIView!
    var homeTutorial = true
    var response: Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
        homecell?.button?.setTitle(" ", for: .normal)
        tutorialTextHomeView.layer.cornerRadius = 30
        if let value = UserDefaults.standard.object(forKey: "Hometv") as? Bool{
            homeTutorial = value
        }
        if (homeTutorial == false){
            tutorialView.isHidden = true
        }
        self.chargeRecomended()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewRec {
            return response?.homeList?.count ?? 0
            
        } else if tableView == self.tableViewFav {
            return response?.homeList?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == self.tableViewRec {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUserRecomCellId", for: indexPath) as? HomeRecommendedUserCell{
                cell.user = response?.homeList?[indexPath.row]
            return cell
            }
        } else if tableView == self.tableViewFav {
            if let cell = tableViewFav.dequeueReusableCell(withIdentifier: "HomeUserFavCellId", for: indexPath) as? HomeUserCell{
                cell.user = response?.homeList?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            self.spinnerView.isHidden = false
            self.favView.isHidden = false
            tableViewFav.dataSource = self
            tableViewFav.delegate = self
            tableViewFav.isHidden = true
            
                    
                let params: [String: Any] = [
                    "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""
                ]
            DataMapper.shared.getFavorites(params: params) { response in
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
                                self.tableViewFav.isHidden = false
                                self.tableViewFav.reloadData()
                                
                                if(response?.status == 0){
                                    //error
                                }else if response?.status == 1{
                                    
                                }else if response?.status == 2{
                                    self.showAlert(title: (response?.msg)!)
                                }else if response?.status == 3{
                                    self.showAlert(title: (response?.msg)!)
                                }else if response?.status == 7 {
                                    self.emptyFavView.isHidden = false
                            }
                        }
                    }
                }
        }else if segmentedHome.selectedSegmentIndex == 0{
            self.recomendedView.isHidden = false
            self.favView.isHidden = true
            self.chargeRecomended()
        }
    }
    
    @IBAction func closeTapped() {
        homeTutorial = false
        let name = homeTutorial
        UserDefaults.standard.set(name, forKey: "Hometv")
        tutorialView.isHidden = true
    }
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    func chargeRecomended(){
        self.spinnerView.isHidden = false
        self.emptyFavView.isHidden = true
        tableViewRec.dataSource = self
        tableViewRec.delegate = self
        tableViewRec.isHidden = true
        
        let params2: [String: Any] = [
            "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""
        ]
    DataMapper.shared.getRecommendedTherapist(params: params2) { response in
            if(response == nil){
                DispatchQueue.main.async {
                    //print("LA RESPUESTA ES")
                    //print(response)
                    self.spinnerView.isHidden = true
                    self.noDataView.isHidden = false
                    self.showAlert(title: "Error en la conexion")

                }
            }else{
                print(response)
                    DispatchQueue.main.async {
                        self.response = response
                        self.spinnerView.isHidden = true
                        self.tableViewRec.isHidden = false
                        self.tableViewRec.reloadData()
                        
                        if(response?.status == 0){
                            //error
                        }else if response?.status == 1{
                    }else if response?.status == 2{
                        self.showAlert(title: (response?.msg)!)
                    }else if response?.status == 3{
                        self.showAlert(title: (response?.msg)!)
                    }else if response?.status == 7 {
                            self.emptyFavView.isHidden = false
                    }
                }
            }
        }

    }
    
}

