//
//  Networking.swift
//  LocationTracker
//
//  Created by Peter Gosling on 7/30/17.
//  Copyright © 2017 Peter Gosling. All rights reserved.
//

import Foundation

class Networking {
    
    enum NetworkResult {
        case success
        case failure
    }
    
    typealias NetworkingCompletion = ((_ result : NetworkResult) -> Void)
    
    static func sendCurrentLocation(_ locationInfo : LocationInfo, completion : @escaping NetworkingCompletion) {
        guard let url = URL.init(string: "https://location-tracker-kotlin.herokuapp.com/currentLocation") else {
            completion(.failure)
            return
        }
        var request = URLRequest.init(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let requestBody : [String : String] = ["phoneNumber" : locationInfo.phoneNumber, "latitude" : locationInfo.latitude, "longitude" : locationInfo.longitude]
        
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            request.httpBody = bodyData
        } catch let error {
            print(error.localizedDescription)
            completion(.failure)
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure)
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    print("Successfully sent location!")
                    completion(.success)
                } else {
                    completion(.failure)
                }
            }
        }
        dataTask.resume()
    }
    
    static func sendRequest<T: StatusCodable>(_ request: URLRequest, _ completion: @escaping (Result<T>) -> ()) {
        let session = URLSession.init(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                response.statusCode == 200 ? completion(.success(T(response.statusCode))) : completion(.failure)
                return
            }
            completion(.failure)
        }
        dataTask.resume()
    }
    
    static func reportLocationPostRequest(_ latitutde: String, _ longitude: String) -> URLRequest {
        guard let phoneNumber = PhoneNumber.retrieveNumber(), let url = URL.init(string: "https://carriers.uslfreight.com/ws/index.asmx/ReportLocation") else {
            fatalError("Error converting string to URL")
        }
        
        let dataString = "Phone=\(phoneNumber)&Username=\(Credentials.username)&Password=\(Credentials.password)&Latitude=\(latitutde)&Longitude=\(longitude)&UserAgent=iOS"
        
        let data = dataString.data(using: .utf8, allowLossyConversion: false)
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("\(String(describing: request.httpBody?.count))", forHTTPHeaderField: "Content-Length")
        return request
    }
    
//    static func fetchTimerDetails() -> URLRequest {
//        guard let
//    }
}













