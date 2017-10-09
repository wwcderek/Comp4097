//
//  MapViewController.swift
//  Comp4097
//
//  Created by Wong Wai Chun on 17/10/9.
//  Copyright © 2017年 Wong Wai Chun. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // set initial location in HKBU
        let initialLocation = CLLocation(latitude: 22.3380838, longitude: 114.18186)
        
        let regionRadius: CLLocationDistance = 300
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
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
