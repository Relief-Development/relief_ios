//
//  MassageProfileFromUserVC.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 6/2/22.
//

import UIKit

class MassageProfileFromUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var descriptionTv: UITextView!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var nameProfile: UILabel!
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var star: UIButton!
    @IBOutlet var heartButton: UIButton?

    
    var response: Response?


    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor(named: "user_light")
        self.tabBarController?.tabBar.invalidateIntrinsicContentSize()
        overrideUserInterfaceStyle = .light
        
        
        if let name = self.user?.name{
            self.nameProfile.text = name
        }
        if let description = self.user?.description{
            self.descriptionTv!.text = description
        }
        if let imageP = self.user?.image{
            if imageP != ""{
                let decodedData = NSData(base64Encoded: imageP, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
                var decodedimage = UIImage(data: decodedData as! Data)
                //print(decodedimage)
                imageProfile.image = decodedimage as! UIImage
                imageProfile.layer.cornerRadius = imageProfile.frame.height / 2.0

               
            }else{
                imageProfile.image = UIImage(systemName: "person.circle.fill")
                imageProfile.tintColor = UIColor(named: "gray")

            }
    }
    }
    @IBAction func callTherapist(){
        if let number = Int(self.user?.phone_number ?? ""){
        guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else { return }
         UIApplication.shared.openURL(url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileUserCell", for: indexPath) as? ProfileUserCell{
            cell.user = response?.list?[indexPath.row]
            return cell
            
        }else {
            return UITableViewCell()
        }
    }

    @IBAction func buttonToDetailTapped(){
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func starButtonTapped(_ button: UIButton) {
        for tag in (1 ... 5) {
            let starButton = (self.view .viewWithTag(tag) as! UIButton)
            starButton.isHighlighted = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(1/120)) {
            let pushedTag = button.tag
            
            
            
            for tag in (1 ... pushedTag) {
                if let starButton = (self.view .viewWithTag(tag) as? UIButton) {
                    starButton.isHighlighted = true
                }
            }
        }
    }
    @IBAction func favButtonnTapped(_ sender: Any) {
        heartButton?.isSelected.toggle()
        
        let params2: [String: Any] = [
            "therapist_id": String(self.user?.id ?? 0),
            "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""
        ]
        
        DataMapper.shared.addRemoveFavorites(params: params2) { response in
            print(params2)
            print(response)
            if(response == nil){
                DispatchQueue.main.async {
                    self.showAlert(title: "Error en la conexion")
                }
            }else{
                
                    DispatchQueue.main.async {
                        self.response = response
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
    @IBAction func locationTapped(){
        if let lat = self.user?.lat {
            UserDefaults.standard.set(lat, forKey: "latLocation")
        }
        if let long = self.user?.long {
            UserDefaults.standard.set(long, forKey: "longLocation")
        }
        if let name = self.user?.name {
            UserDefaults.standard.set(name, forKey: "nameLocation")
        }
        
        if let map = storyboard?.instantiateViewController(withIdentifier: "MapUserLocation"){            self.present(map, animated: true, completion: nil)
        }
    }
    func configureButton(){
        let imageHeart = UIImage(named: "ic_favoritoInactivo")
        let imageHeartFilled = UIImage(named: "ic_favoritoActivo")
        heartButton?.setImage(imageHeart, for: .normal)
        heartButton?.setImage(imageHeartFilled, for: .selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButton()
        self.spinnerView.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
        for tag in (1 ... 5) {
            let starButton = (self.view.viewWithTag(tag) as! UIButton)
            starButton.isHighlighted = false
        }
        
        if var valoration = Float(user?.media ?? "0") {
            valoration = round(valoration)
            
            if valoration > 0 {
                for tag in (1 ... Int(valoration)) {
                    if let starButton = (self.view.viewWithTag(tag) as? UIButton) {
                        starButton.isHighlighted = true
                    }
                }
            }
        }
            
        let params: [String: Any] = [
            "id": self.user?.id,
            "api_token": AppData.shared.apiToken ?? ""
        ]
        print(params)
        DataMapper.shared.getServices(params: params) { response in
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
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }

   
}
