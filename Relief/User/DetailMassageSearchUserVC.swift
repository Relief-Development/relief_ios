//
//  DetailMassageSearchUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

//
//  DetailMassageSearchUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 6/2/22.
//

import UIKit

class DetailMassageSearchUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var massage:Massage?
    @IBOutlet var descriptionTv: UITextView!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var spinnerView: UIView!
    @IBOutlet var noDataView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var response: Response?





    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserForSearchMassageIdentifier", for: indexPath) as? DetailMassageUserCell{
            cell.user = response?.list?[indexPath.row]
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let massageFromUser = storyboard?.instantiateViewController(withIdentifier: "MassageProfileFromUser") as? MassageProfileFromUserVC{
            massageFromUser.modalPresentationStyle = .fullScreen
            massageFromUser.user = response?.list?[indexPath.row]
            self.present(massageFromUser, animated: true, completion: nil)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Masajes relajantes"
        overrideUserInterfaceStyle = .light
        if let name = self.massage?.name{
            self.navigationItem.title = name
        }
        if let description = massage?.description{
            self.descriptionTv!.text = description
        }
        if let imageP = self.massage?.image{
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.spinnerView.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        
                
            let params: [String: Any] = [
                "id": self.massage?.id
            ]
            print(params)
        DataMapper.shared.getTherapistForMassage(params: params) { response in
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


