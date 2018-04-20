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
        print("you are inside the addPin function")
        if gestureRecognizer.state == .began {
            print("the gesture just started")
        }else if gestureRecognizer.state == .ended {
            print("Added Pin")
        }
    }

}

extension TravelMapViewController: MKMapViewDelegate {
    
    


    
    
}


