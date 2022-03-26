//
//  MapMassageUserVC.swift
//  Relief
//
//  Created by Alejandro Botana on 24/3/22.
//
import MapKit
import UIKit

class MapMassageUserVC: UIViewController, MKMapViewDelegate{
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = UserDefaults.standard.object(forKey: "latLocation") as! Double
        let long = UserDefaults.standard.object(forKey: "longLocation") as! Double
        let name = UserDefaults.standard.object(forKey: "nameLocation") as! String
        
        let mass1 = Massagist()
        mass1.name = name
        mass1.lng = long
        mass1.lat = lat
        
        let massagists = [mass1]
        
        mapView.addAnnotations(massagists)
        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        centerInPosition(position: coordinate)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)

    }
    @IBAction func backToDetail(){
        self.dismiss(animated: true)
    }
    func centerInPosition(position:CLLocationCoordinate2D){
        mapView.setCenter(position, animated: true)
    }
}
