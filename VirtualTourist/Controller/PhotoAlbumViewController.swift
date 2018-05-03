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

class PhotoAlbumViewController: UIViewController, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pin: Pin!
    var photos = [AnyObject]()
    
    var dataController:DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView?.reloadData()
        
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
        
        //Testing latitude and longitude image search
        self.searchByLatAndLon()
    }
    
    
    
    
    // Function to search
    func searchByLatAndLon() {

            // MARK: Set necessary parameters!
            let methodParameters: [String: AnyObject] = [
                Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.SearchMethod as AnyObject,
                Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey as AnyObject,
                Constants.FlickrParameterKeys.BoundingBox: bboxString() as AnyObject,
                Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.UseSafeSearch as AnyObject,
                Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL as AnyObject,
                Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat as AnyObject,
                Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback as AnyObject
                
            ]
        
            displayGalleryFromFlickrBySearch(methodParameters)

    }
    
    private func bboxString() -> String {
        if (MapClient.latitude != nil) && (MapClient.longitude != nil) {
            let minimumLon = max(MapClient.longitude! - Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.0)
            let minimumLat = max(MapClient.latitude! - Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.0)
            
            let maximumLon = min(MapClient.longitude! + Constants.Flickr.SearchBBoxHalfWidth, Constants.Flickr.SearchLonRange.1)
            let maximumLat = min(MapClient.latitude! + Constants.Flickr.SearchBBoxHalfHeight, Constants.Flickr.SearchLatRange.1)
            
            return "\(minimumLon), \(minimumLat), \(maximumLon), \(maximumLat)"
        }else{
            return "0,0,0,0"
        }
    }
    
    private func displayGalleryFromFlickrBySearch(_ methodParameters: [String: AnyObject]) {
        let session = URLSession.shared
        
        let request = URLRequest(url: FlickrUrlFromParameters(parameters: methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("There was an error with your request")
                return
            }
            
            guard let data = data else {
                print("We couldnt find any data")
                return
            }
            
            var parsedResult: [String:AnyObject]!
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            }catch{
                return
            }
            
            guard let photosDictonary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject] else {
                print("Couldnt find any photos in dictonary.")
                return
            }
    
            guard let photoArray = photosDictonary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] else {
                print("Couldnt get any photo from the array")
                return
            }
            
            for everyPhoto in photoArray {
                self.photos.append(everyPhoto as AnyObject)
            }
            
            self.performUIUpdatesOnMain {
                self.collectionView.reloadData()
            }
        }
        task.resume()
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
    
    //MARK: Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = self.photos[(indexPath as NSIndexPath).row]
        
        if let imageUrlString = photo[Constants.FlickrResponseKeys.MediumURL] as? String {
            let imageUrl = URL(string: imageUrlString)
            
            if let imageData = try? Data(contentsOf: imageUrl!) {
                self.performUIUpdatesOnMain {
                    cell.imageCell?.image = UIImage(data: imageData)
                }
            }
        }

    return cell
    }

    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
