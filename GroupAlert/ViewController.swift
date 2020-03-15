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

	let locationManager = CLLocationManager()
	var currentLocation = CLLocation()
	let zoomedRegionInMeters: Double = 3000

    override func viewDidLoad() {
        super.viewDidLoad()
		checkLocationServices()
		currentLocation = locationManager.location!
		mapView.delegate = self
		   
		
		
		

        // Do any additional setup after loading the view.
    }
	
	func setupMapView () {
		mapView.mapType = .standard
		   mapView.isZoomEnabled = true
		   mapView.isScrollEnabled = true
		mapView.showsCompass = true
		
	}
	
	func setupLocationManager () {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}
	
	func checkLocationServices () {
		if CLLocationManager.locationServicesEnabled() {
			setupLocationManager()
			checkLocationAuthorization()
		}
		
	}
	
	func centerViewOnUserLocation() {
		if let locationCoordinate = locationManager.location?.coordinate {
			let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: zoomedRegionInMeters, longitudinalMeters: zoomedRegionInMeters)
			mapView.setRegion(region, animated: true)
		}
	}
	
	func checkLocationAuthorization() {
		switch CLLocationManager.authorizationStatus() {
		case .authorizedWhenInUse:
			setupMapView()
			centerViewOnUserLocation()
			locationManager.startUpdatingLocation()
			
			break
		case .denied:
			//Instruct on how to do so
			break
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		case .restricted:
			//Show an alert letting them know whats up
			break
		case .authorizedAlways:
			break
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, latitudinalMeters: zoomedRegionInMeters, longitudinalMeters: zoomedRegionInMeters)
		mapView.setRegion(region, animated: true)
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		checkLocationAuthorization()
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

