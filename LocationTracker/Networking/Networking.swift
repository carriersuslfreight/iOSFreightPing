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
    
    func sendCurrentLocation(_ locationInfo : LocationInfo, completion : @escaping NetworkingCompletion) {
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
    
    func sendRequest<T: Parseable>(_ request: URLRequest, _ completion: @escaping (Result<T>) -> ()) {
        
    }
}













