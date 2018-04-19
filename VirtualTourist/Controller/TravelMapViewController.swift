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
    }


}

extension TravelMapViewController: MKMapViewDelegate {
    
}


