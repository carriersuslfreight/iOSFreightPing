//
//  LocationManager.swift
//  LocationTracker
//
//  Created by Peter Gosling on 7/26/17.
//  Copyright © 2017 Peter Gosling. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    private var timer : Timer!
    
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
        
    }
    
    func start() {
        self.locationManager.startUpdatingLocation()
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { (Timer) in
            print(self.currentLocation)
        })
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       self.currentLocation = locations[0]
    }
}
