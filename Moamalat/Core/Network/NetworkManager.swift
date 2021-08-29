//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//
import Foundation

import UIKit
import Alamofire


typealias APISuccess = ((_ response: Any?) -> ())?
typealias APIFailure = ((_ response: Any?, _ error: Error?) -> ())?
typealias APIResponseHeaders = ((_ responseHeaders: [AnyHashable : Any?]?) -> ())?


struct NetworkManager {
    
    static let manager: NetworkManager = {
        return NetworkManager()
    }()
    
    func request(endPoint: EndPoint, success: APISuccess, failure: APIFailure) {
        
        LoadingIndicator.showActivityIndicator()
        AF.request(endPoint.url,
                   method: httpMethod(forEndPoint: endPoint),
                   parameters: endPoint.parameters,
                   encoding: encoding(forEndPoint: endPoint),
                   headers: httpHeaders(forEndPoint: endPoint)).validate().responseJSON { response in
                    
                    do {
                        if let data = response.data, data.count > 0 {
                            
                            if endPoint.configurations?.handleResponseModelManually ?? false {
                                
                                switch response.result {
                                case .success(let value):
                                    
                                    success?(value)
                                    
                                case .failure(let error):
                                    failure?(nil, error)
                                }
                                return
                            }else{
                                
                                let responseModel = try JSONDecoder().decode(APIResponseModel.self, from: data)
                                print(responseModel)
                                APIResponseHandler().handleResponse(responseModel, configurations: endPoint.configurations, success: { (model) in
                                    
                                    success?(model)
                                    
                                }) { (responseError, error) in
                                    
                                    failure?(responseError, response.error)
                                    
                                }
                            }
                            
                            
                        } else {
                            
                            if !(endPoint.configurations?.handleNetworkErrorsManually ?? false) {
                                
                            failure?(nil, response.error)
                                
                            }
                            failure?(nil, response.error)
                          
                        }
                        
                    } catch {

                        if !(endPoint.configurations?.handleNetworkErrorsManually ?? false) {
                            
                        }
                        failure?(nil, response.error)
                    }
                    
                   }
        
    }
    
}

func cancelAllRequests() {
    
    let sessionManager = Alamofire.Session.default
    sessionManager.session.getAllTasks { tasks in
        tasks.forEach { $0.cancel() }
        
    }
}

func cancelRequestWithURL(url: String) {
    
    let sessionManager = Alamofire.Session.default
    sessionManager.session.getAllTasks { tasks in
        
        tasks.forEach {
            if ($0.originalRequest?.url?.absoluteString.contains(url) ?? false) {
                $0.cancel()
            }
        }
    }
}


extension NetworkManager {
    
    func httpMethod(forEndPoint endPoint: EndPoint) -> HTTPMethod {
        
        switch endPoint.method {
        
        case .get:
            return HTTPMethod.get
            
        case .post:
            return HTTPMethod.post
            
        case .put:
            return HTTPMethod.put
            
        case .delete:
            return HTTPMethod.delete
        }
    }
    
    func encoding(forEndPoint endPoint: EndPoint) -> ParameterEncoding {
        
        if let encoding = endPoint.encoding {
            
            return parameterEncoding(forAPIEncoding: encoding)
        }
        
        switch endPoint.method {
        
        case .get:
            return URLEncoding.default
            
        case .post:
            return JSONEncoding.default
            
        default:
            return JSONEncoding.default
        }
    }
    
    func parameterEncoding(forAPIEncoding apiEncoding: APIEncoding) -> ParameterEncoding {
        
        switch apiEncoding {
        
        case .url:
            return URLEncoding.default
            
        case .json:
            return JSONEncoding.default
            
        case .query:
            return URLEncoding.queryString
            
        case .noBrackets:
            return CustomGetEncodingWithoutBrackets()
            
        }
    }
    
    func httpHeaders(forEndPoint endPoint: EndPoint) -> HTTPHeaders? {
        
        var headers: HTTPHeaders = [:]
        
        headers = defaultHTTPHeaders()
        
        guard let endPointHeaders = endPoint.headers else {
            
            return headers
        }
        
        for header in endPointHeaders {
            headers.add(name: header.key, value: header.value)
        }
        
        return headers
    }
    
    func defaultHTTPHeaders() -> HTTPHeaders {
        
        var headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Accept-Language" :LanguageManager.manager.currentLanguageCode,
            "appId" : "mobile",
            "UDID" : UIDevice.current.identifierForVendor!.uuidString,
            "osName" : "IOS",
        ]
        
        if let userToken = CachingManager.token() {
            headers["token"] = "\(userToken)"
        }
        
        return headers
    }
}

extension NetworkManager {
    
    struct CustomGetEncodingWithoutBrackets: ParameterEncoding {
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var request = try! URLEncoding().encode(urlRequest, with: parameters)
            let urlString = request.url?.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "=")
            request.url = URL(string: urlString!)
            return request
        }
    }
}
