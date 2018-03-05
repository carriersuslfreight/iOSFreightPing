//
//  LocationInfo.swift
//  LocationTracker
//
//  Created by Peter Gosling on 7/30/17.
//  Copyright © 2017 Peter Gosling. All rights reserved.
//

import Foundation

struct LocationInfo {
    let phoneNumber : String
    let latitude : String
    let longitude : String
    
    init(_ phoneNumber : String, _ latitude : String, _ longitude : String) {
        self.phoneNumber = phoneNumber
        self.latitude = latitude
        self.longitude = longitude
    }
}
