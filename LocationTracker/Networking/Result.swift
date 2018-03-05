//
//  Result.swift
//  LocationTracker
//
//  Created by Peter Gosling on 3/4/18.
//  Copyright © 2018 Peter Gosling. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure
}
