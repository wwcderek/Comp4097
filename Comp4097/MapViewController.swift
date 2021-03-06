//
//  MapViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/9.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import RealmSwift

class MapViewController: UIViewController {
    var number = 0
    var realmResults:Results<Property>?
    var results:Results<Estates>?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: Bundle.main.url(forResource: "privateEstates", withExtension: "realm"),
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
        
        // Open the Realm with the configuration
        let value = String(describing: (realmResults?[number].estate)!)
        let realm = try! Realm(configuration: config)
        results = realm.objects(Estates.self).filter("Name = %@",value)
       // print("First record is \((results?[0].Name)!)");
        print((results?[0].Name)!)
        
          let initialLocation = CLLocation(latitude: Double((results?[0].Latitude)!), longitude: Double((results?[0].Longitude)!))
       
        
        // set initial location in HKBU
//        let initialLocation = CLLocation(latitude: 22.370174, longitude: 114.175935)
        
        let regionRadius: CLLocationDistance = 300
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        let destination = MKPointAnnotation()
        
        destination.coordinate = CLLocationCoordinate2D(latitude: Double((results?[0].Latitude)!), longitude: Double((results?[0].Longitude)!))
        destination.title = realmResults?[number].estate
        destination.subtitle = realmResults?[number].name 
        
        mapView.addAnnotation(destination)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
