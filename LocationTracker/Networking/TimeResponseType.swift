//
//  TimeResponseType.swift
//  LocationTracker
//
//  Created by Peter Gosling on 3/9/18.
//  Copyright © 2018 Peter Gosling. All rights reserved.
//

import Foundation
import Kanna

enum ParseError: Error {
    case xmlParseError
    case apiError
}

struct TimeResponseType: Parseable {
    let time: Double
    init(data: Data) throws {
        do {
            guard let result = try? Kanna.XML(xml: data, encoding: .utf8), let time = result.xpath("result").first?.text, let doubleTime = Double(time) else {
                throw ParseError.xmlParseError
            }
            self.time = doubleTime * 60
        } catch {
            throw ParseError.xmlParseError
        }
    }
}
