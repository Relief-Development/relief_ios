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

    }
}
