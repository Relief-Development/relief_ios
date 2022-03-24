//
//  MapUserVC.swift
//  Relief
//
//  Created by Javier Eduardo Rodriguez Ardila on 1/2/22.
//

import MapKit
import UIKit
import CoreLocation

class MapUserVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var backgroundBar: UIView?
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tutorialView: UIView!
    @IBOutlet var tutorialTextMapView: UIView!
    var mapTutorial = true
    var response: Response?

    
//    Esther Moreno lat and long
//    40.436797570299035, -3.716440514606122
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundBar?.layer.cornerRadius = 10
        tutorialTextMapView.layer.cornerRadius = 30
        overrideUserInterfaceStyle = .light
        
        
        
        if let value = UserDefaults.standard.object(forKey: "Maptv") as? Bool{
            mapTutorial = value
        }
        if (mapTutorial == false){
            tutorialView.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let params: [String: Any] = [
            "api_token": UserDefaults.standard.object(forKey: "token") as? String ?? ""

        ]

        DataMapper.shared.getTherapistInMap(params: params) { response in
            DispatchQueue.main.async {
            self.response = response
                self.mapView.reloadInputViews()
            print("AQUI ESTA LA RESPUESTA")
            print(response)
            if(response == nil){
                self.showAlert(title: "Error en la conexion")
            }else{
                DispatchQueue.main.async {

                    self.response = response

                    if(response?.status == 0){
                        self.showAlert(title: (response?.msg)!)

                    }else if response?.status == 1{
                        self.setupMap()
                        print(response?.profile)

                    }else if response?.status == 401{
                        self.showAlert(title: (response?.msg)!)
                    }
                }
            }
            }
            
        }
    }
    
    func showUserLocation() {
        guard let userCoordinates = locationManager?.location?.coordinate else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: userCoordinates, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    func getUserLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
        }
        else {
            // Notificar al usuario que tiene el gps desactivado
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            // Notificar al usuario. Localización restringida por configuración paternal
            break
        case .denied:
            // Notificar al usuario. Localización restringida para la app en ajustes
            break
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showUserLocation()
            }
            
        @unknown default:
            break
        }
    }
    
    @IBAction func closeTapped() {
        mapTutorial = false
        let name = mapTutorial
        UserDefaults.standard.set(name, forKey: "Maptv")
        tutorialView.isHidden = true
    }
    func showAlert(title:String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            
        })
        alertController.addAction(ok)

        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupMap() {
        for massagist in response?.profile ?? [] {
            if (massagist.lat ?? 0.0) != 0.0 && (massagist.long ?? 0.0) != 0.0 {
                let annotation = UserAnnotation(with: massagist)
                mapView.addAnnotation(annotation)
            }
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
//        let usLocation = MKPointAnnotation()
//        usLocation.coordinate = CLLocationCoordinate2D(latitude:(mapView?.userLocation.coordinate.latitude)!,longitude:(mapView?.userLocation.coordinate.longitude)!)
//
//        print(usLocation.coordinate)
//
//        getUserLocation()
    }
}

