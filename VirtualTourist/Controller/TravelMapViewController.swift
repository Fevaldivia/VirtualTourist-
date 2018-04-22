//
//  TravelMapViewController.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/17/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//
import UIKit
import MapKit
import CoreData

class TravelMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var dataController:DataController!
    
    var pins:[Pin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Assign map delegate to itself, to use classes
        mapView.delegate = self
        // Instantiate gesture recognizer for mapview
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addPin))
        mapView.addGestureRecognizer(gestureRecognizer)
        //MARK: Fetch Request
        let fetchRequest:NSFetchRequest<Pin> = Pin.fetchRequest()
        
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            pins = result
            loadPins()
        }
    }
    
    @objc func addPin(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            // creating a new pin
            let pin = Pin(context: dataController.viewContext)
            pin.latitude = locationCoordinate.latitude
            pin.longitude = locationCoordinate.longitude
            // saving to the persistant store
            try? dataController.viewContext.save()
            pins.insert(pin, at: 0)
            // everytime that our tap begin we reaload the pins
            loadPins()
        }   
    }
    
    func loadPins() {
        for location in pins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        //TODO: Implement push to the next controller
        let selectedAnnotation = view.annotation
        
        MapClient.latitude = selectedAnnotation!.coordinate.latitude
        MapClient.longitude = selectedAnnotation!.coordinate.longitude
        
         mapView.deselectAnnotation(view.annotation, animated: true)
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "PhotoAlbum") as? UIViewController
        present(controller!, animated: true, completion: nil)
    }

}


