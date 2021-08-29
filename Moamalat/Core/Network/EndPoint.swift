//
//  EndPoint.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/12/1442 AH.
//

import Foundation
import UIKit

enum APIMethod {
    
    case get
    case post
    case put
    case delete
}

enum APIEncoding {
    
    case url
    case json
    case query
    case noBrackets
}

struct EndPoint {
    
    // MARK: - Variables
    var method: APIMethod
    var parameters: [String : Any]?
    var encoding: APIEncoding?
    var headers: [String : String]?
    var configurations: APIConfiguration?
    var fullURL: String?
    
    var url: String {
        
        return fullURL ?? "\(environment.baseURL)"
        
    }
    
    
    // MARK: - Initialization

    init() {
        
    
        self.method = .post
        self.parameters = nil
        self.encoding = nil
        self.headers = nil
        self.configurations = nil
        self.fullURL = nil
    }
    

    init(
        method: APIMethod,
         parameters: [String : Any]?,
         encoding: APIEncoding? = nil,
         headers: [String : String]? = nil,
         configurations: APIConfiguration? = nil,
         fullURL: String? = nil) {
        
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        self.configurations = configurations
        self.fullURL = fullURL
    }
}

struct APIConfiguration {
    
    var handleErrorsManually: Bool = false
    var handleNetworkErrorsManually: Bool = false
    var handleNetworkActivityIndicatorManually: Bool = false
    var handleResponseModelManually: Bool = true
    var handleActivityIndicatorManually: Bool = false
}
