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
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var timeInterval: Double = 10.0
    var isUpdating: Bool = false
    
    private var timer : Timer!
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.locationManager = CLLocationManager()
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            self.locationManager.allowsBackgroundLocationUpdates = true
            self.locationManager.pausesLocationUpdatesAutomatically = false
        }
    }
    
    func start() {
        self.locationManager.startUpdatingLocation()
        self.isUpdating = true
        
        self.timer = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: { (Timer) in
            guard let currentLocation = self.currentLocation else {
                return
            }
            
            let locationRequest = Networking.reportLocationPostRequest(String(currentLocation.coordinate.latitude), String(currentLocation.coordinate.longitude))
            Networking.sendRequest(locationRequest, { (result: Result<RecordLocationResponse>) in
                switch result {
                case .success(let response):
                    print(response)
                //Happy
                case .failure:
                    print("Failure")
                    //Discuss Failure
                }
            })
        })
    }
    
    func stop() {
        self.locationManager.stopUpdatingLocation()
        self.isUpdating = false
        self.timer.invalidate()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations[0]
    }
}
