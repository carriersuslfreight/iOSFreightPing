//
//  LocationReponseType.swift
//  LocationTracker
//
//  Created by Peter Gosling on 3/8/18.
//  Copyright © 2018 Peter Gosling. All rights reserved.
//

import Foundation

struct LocationResponseType: StatusCodable {
    let statusCode: Int
    init(_ statusCode: Int) {
        self.statusCode = statusCode
    }
}
