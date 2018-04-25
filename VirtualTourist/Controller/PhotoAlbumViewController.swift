//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/21/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//

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
    
    
    
    
    
    
    
    // MARK: Create url for flickr
    private func FlickrUrlFromParameters(parameters: [String:AnyObject]) -> URL {
        var components = URLComponents()
        
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        return components.url!
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
