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
        
        let annotation = [Massagist()]
        mapView.addAnnotation(annotation as! MKAnnotation)
    }
}
