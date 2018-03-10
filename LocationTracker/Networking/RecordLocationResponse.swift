//
//  RecordLocationType.swift
//  LocationTracker
//
//  Created by Peter Gosling on 3/5/18.
//  Copyright © 2018 Peter Gosling. All rights reserved.
//

import Foundation
import Kanna

struct RecordLocationResponse: Parseable {

    let result: String
    init(data: Data) throws {
        guard let xml = try? Kanna.XML(xml: data, encoding: .utf8), let result = xml.xpath("result").first?.text else {
            throw ParseError.xmlParseError
        }
        if result != "Success" {
            throw ParseError.apiError
        }
        self.result = result
    }
}
