//
//  APIClient.swift
//  MacWealth
//
//  Created by Dan Malone on 08/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa
import Alamofire

public enum APIClientError: Error {
    case BadRequest
    case Serialization
}

class APIClient {
    
    private static let baseUrl = "https://api.drivewealth.net/v1"
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    init() {}
    
    class func requestJSON(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil) -> Promise<Any> {
        let promise = Promise<Any>()
        
        let request = Alamofire.request(baseUrl + url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON(completionHandler: { (dataResponse) in
            
            switch dataResponse.result {
            case .success(let value):
                promise.thenClosure?(value)
            case .failure(let error):
                print(String(data: dataResponse.data!, encoding: String.Encoding.utf8))
                promise.failureClosure?(APIClientError.BadRequest)
            }
        })
        
        return promise
    }
    
    class Promise<T> {
        
        fileprivate var thenClosure: ((T) -> Void)?
        fileprivate var failureClosure: ((Error) -> Void)?
        
        func then(_ then: @escaping (T) -> Void) -> Self {
            thenClosure = then
            return self
        }
        
        func failure(_ failure: @escaping (Error) -> Void) {
            failureClosure = failure
        }
    }
}
