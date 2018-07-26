//
//  detailesViewController.swift
//  Task1
//
//  Created by Nour Abukhaled on 3/13/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class AnnotationView: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        
        self.coordinate = coordinate
        
        super.init()
    }
}

class detailesViewController: UIViewController {
   
    var latitude:Double = 0.00
    var longitude:Double = 0.00
    var titleName: String = ""
    
    @IBOutlet weak var mapView: MKMapView!


    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        self.title = titleName

        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        
        let annotaitonView = AnnotationView(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        mapView.addAnnotation(annotaitonView)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func startNavigation(_ sender: Any) {
        
        let stringURL = "comgooglemaps://?saddr=&daddr=\(Float(latitude)),\(Float(longitude))&directionsmode=driving"
        
        let url = URL(string: stringURL)!
        
        if UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url)
            
        }else {
            
            print("Could not open google maps")
        }
    }
}









