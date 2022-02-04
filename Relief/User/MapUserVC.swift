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
    
//    Esther Moreno lat and long
//    40.436797570299035, -3.716440514606122
    
    var locationManager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundBar?.layer.cornerRadius = 10
        
        let mass1 = Massagist()
        mass1.name = "Esther Moreno"
        mass1.serviceDescription = "Masajes relajantes"
        mass1.lng = -3.716440514606122
        mass1.lat = 40.439797570299035
        
        let mass2 = Massagist()
        mass2.name = "La Pili"
        mass2.serviceDescription = "Masajes sensuales"
        mass2.lng = -3.718440514506122
        mass2.lat = 40.436797570199035
        
        let mass3 = Massagist()
        mass3.name = "Antonia la Vallecana"
        mass3.serviceDescription = "Masajes de espalda"
        mass3.lng = -3.711440574506122
        mass3.lat = 40.435797590199035
        
        let massagists = [mass1, mass2, mass3]
        
        mapView.addAnnotations(massagists)
        
        let usLocation = MKPointAnnotation()
        usLocation.coordinate = CLLocationCoordinate2D(latitude:(mapView?.userLocation.coordinate.latitude)!,longitude:(mapView?.userLocation.coordinate.longitude)!)
        
        print(usLocation.coordinate)
        
        getUserLocation()
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
    
    
    
}

