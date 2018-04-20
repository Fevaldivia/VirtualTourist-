//
//  TravelMapViewController.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/17/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//
import UIKit
import MapKit

class TravelMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addPin))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func addPin(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            
            Pin.latitude = locationCoordinate.latitude
            Pin.longitude = locationCoordinate.longitude
            
            print(Pin.latitude, Pin.longitude)
        }else if gestureRecognizer.state == .ended {
            
        }
    }

}

extension TravelMapViewController: MKMapViewDelegate {
    
    


    
    
}


