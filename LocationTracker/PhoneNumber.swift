//
//  PhoneNumber.swift
//  LocationTracker
//
//  Created by Peter Gosling on 7/30/17.
//  Copyright © 2017 Peter Gosling. All rights reserved.
//

import Foundation

struct PhoneNumber {
    static func savePhoneNumber(_ number : String) {
        UserDefaults.standard.set(number, forKey: "PhoneNumber")
    }
    
    static func retrieveNumber() -> String? {
        if let number = UserDefaults.standard.value(forKey: "PhoneNumber") as? String {
            return number
        }
        return nil
    }
}
