//
//  Connection.swift
//  Relief
//
//  Created by Alejandro Botana on 6/3/22.
//

import Foundation
import UIKit


final class Connection {
    
    let baseUrl = "http://localhost/relief_API/public/api/"
    
    
    func connection(to endpoint: String ,params: [String: Any]?, method: String ,completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: baseUrl+endpoint) else {
            completion(nil)
            return
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil)
                return
            }
            
            urlRequest.httpMethod = method
            urlRequest.httpBody = paramsData
        }
        
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
            
            guard error == nil else {
                completion(nil)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            print("HTTP Status code: \(httpResponse.statusCode)")
            
            completion(data)
        }
        networkTask.resume()
    }
    
}

