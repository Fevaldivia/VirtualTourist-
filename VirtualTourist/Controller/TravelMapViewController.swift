//
//  TravelMapViewController.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/17/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//
import UIKit
import MapKit

class TravelMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assign map delegate to itself, to use classes
        mapView.delegate = self
        // Instantiate gesture recognizer for mapview
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addPin))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func addPin(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            
            Pin.latitude = locationCoordinate.latitude
            Pin.longitude = locationCoordinate.longitude
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: Pin.latitude!, longitude: Pin.longitude!)
            
            mapView.addAnnotation(annotation)
        }else if gestureRecognizer.state == .ended {
            
        }
    }

}


