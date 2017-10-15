//
//  Map2ViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/14.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import MapKit

class Map2ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        let initialLocation = CLLocation(latitude: 22.3692, longitude: 114.1743)
        
        
        // set initial location in HKBU
        //        let initialLocation = CLLocation(latitude: 22.370174, longitude: 114.175935)
        
        let regionRadius: CLLocationDistance = 300
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        let destination = MKPointAnnotation()
        
        destination.coordinate = CLLocationCoordinate2D(latitude: 22.3692, longitude: 114.1743)
        destination.title = "Festival City"
        destination.subtitle = "酒店式靚裝，有泳池會所"
        
        mapView.addAnnotation(destination)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        let identifier = "pin"
        
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        } else {
            
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        self.performSegue(withIdentifier: "showSelection3", sender: nil)
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
