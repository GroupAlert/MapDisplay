//
//  ViewController.swift
//  GroupAlert
//
//  Created by Stephen Baity on 3/7/20.
//  Copyright © 2020 GroupAlert. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	@IBOutlet weak var mapView: MKMapView!

	var locationManager = CLLocationManager()
	var currentLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
		locationManager.requestWhenInUseAuthorization()
		currentLocation = locationManager.location!
		

		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
		
		mapView.delegate = self
		   mapView.mapType = .standard
		   mapView.isZoomEnabled = true
		   mapView.isScrollEnabled = true
		mapView.showsCompass = true
		
		
		let neighborhoodSpan = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
		
		let region = MKCoordinateRegion(center: currentLocation.coordinate, span: neighborhoodSpan)
		mapView.setRegion(region, animated: true)
		
		
		
		
		

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

