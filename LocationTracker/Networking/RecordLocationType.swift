//
//  RecordLocationType.swift
//  LocationTracker
//
//  Created by Peter Gosling on 3/5/18.
//  Copyright © 2018 Peter Gosling. All rights reserved.
//

import Foundation

struct RecordLocationType: Parseable {
    let data: Data
    init(data: Data) {
        self.data = data
    }
}
