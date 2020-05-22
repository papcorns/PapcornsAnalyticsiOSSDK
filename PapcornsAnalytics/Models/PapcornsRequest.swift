//
//  PapcornsRequest.swift
//  PapcornsAnalytics
//
//  Created by Kaan Baris BAYRAK on 22.05.2020.
//  Copyright © 2020 Papcorns. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

typealias PapcornsRequestFailClosure = (Error) -> ()
typealias PapcornsEmptySuccessClosure = ()->()

class PapcornsRequest<T:Codable> {
    
    typealias PapcornsRequestSuccessClosure = (PapcornsAPISuccess) -> ()
    
    var path:String {
        return "/"
    }
    var httpMethod:HTTPMethod {
        return .GET
    }
    var needsAuthentication:Bool {
        return true
    }
    var dateDecodingStrategy:JSONDecoder.DateDecodingStrategy {
        return .secondsSince1970
    }
    
    private var httpHeaders:[String:String] = [
        "Content-Type":"application/json",
        "Accept":"application/json"
    ]
    
    private var queryItems:[URLQueryItem]?
    private var bodyItems:[String:Any]?
    
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = PapcornsConfigManager.shared.config.urlScheme
        components.host = PapcornsConfigManager.shared.config.host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    func addHeader(name:String, value:String) {
        httpHeaders[name] = value
    }
    
    
    func addQueryItem(name:String, value:String?) {
        if queryItems == nil {
            queryItems = []
        }
        queryItems?.append(.init(name: name, value: value))
    }
    
    func addBodyItem(name:String, value:Any) {
        if bodyItems == nil {
            bodyItems = [:]
        }
        bodyItems?[name] = value
    }

    private func generateRequest(url:URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        self.httpHeaders.forEach({request.setValue($0.value, forHTTPHeaderField: $0.key)})
               
        if let bodyItems = self.bodyItems, let bodyData = try? JSONSerialization.data(withJSONObject: bodyItems, options: []) {
           request.httpBody = bodyData
        }
        return request
    }
    
    func startRequest(_ onSuccess:PapcornsRequestSuccessClosure? = nil, _ onFail:PapcornsRequestFailClosure? = nil) {
        guard let url = self.url else {
            print("PapcornsAnalytics -> Url is missing")
            return
        }
        let session = URLSession.shared
        let request = generateRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
          
            if let error = error {
                onFail?(error)
            } else if let data = data {
                
                let responseOK = {
                    do {
                      let decoder = JSONDecoder()
                      decoder.dateDecodingStrategy = self.dateDecodingStrategy
                        let response = try decoder.decode(PapcornsAPISuccess.self , from: data)
                        onSuccess?(response)
                    } catch {
                        onFail?(error)
                    }
                }
                
                //On fail
                let apiError = {
                    do {
                      let decoder = JSONDecoder()
                      decoder.dateDecodingStrategy = self.dateDecodingStrategy
                        let response = try decoder.decode(PapcornsAPIError.self , from: data)
                        onFail?(response.error)

                    } catch {
                        onFail?(error)
                    }
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode >= 200 && response.statusCode < 300 {
                        responseOK()
                    }
                    else {
                        apiError()
                    }
                }
                

                
            }
        }
        
        task.resume()
    }
    
    
    func request(_ onSuccess:PapcornsRequestSuccessClosure? = nil, _ onFail:PapcornsRequestFailClosure? = nil) {
        startRequest({ (response) in
            onSuccess?(response)
        }) { (error) in
            onFail?(error)
        }
    }

}
