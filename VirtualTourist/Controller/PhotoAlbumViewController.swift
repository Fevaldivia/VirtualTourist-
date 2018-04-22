//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/21/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var pin: Pin!
    
    var dataController:DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assign map delegate to itself, to use classes
        mapView.delegate = self
        //Add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: MapClient.latitude!, longitude: MapClient.longitude!)
        mapView.addAnnotation(annotation)
        // Zoom view on the map
        let pinLocation = CLLocationCoordinate2D(latitude: MapClient.latitude!, longitude: MapClient.longitude!)
        let viewRegion = MKCoordinateRegionMakeWithDistance(pinLocation, 500, 500)
        mapView.setRegion(viewRegion, animated: false)
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
