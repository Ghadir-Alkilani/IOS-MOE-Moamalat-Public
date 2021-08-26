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
       // loadingView.startAnimating()
        AF.request(endPoint.url,
                   method: httpMethod(forEndPoint: endPoint),
                   parameters: endPoint.parameters,
                   encoding: encoding(forEndPoint: endPoint),
                   headers: httpHeaders(forEndPoint: endPoint)).validate().responseJSON { response in
                print(endPoint.url)
                    print(endPoint.url)
                
                 //   LoadingIndicator.hideActivityIndicator()

                    do {
                        if let data = response.data, data.count > 0 {
                            print(response)
                            print(response.data)
                            print(response.value)
                            
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
                                     // print(response.error!)
      
                                  }
                            }
                         
                            
                        } else {
                            
                            if !(endPoint.configurations?.handleNetworkErrorsManually ?? false) {
                               
                           //     SnackBar.showMessage(response.error?.localizedDescription)
                               

                            }
                            failure?(nil, response.error)
                            print(response.error!)
                         //   SnackBar.showMessage("bobobmnonfd")
//                            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//
//                            if var topController = keyWindow?.rootViewController {
//                                while let presentedViewController = topController.presentedViewController {
//                                    topController = presentedViewController
//                                    SnackBar.showMessage("\(response.error!)")
//                                }
//
//                                SnackBar.showMessage("\(response.error!)")
//                                // topController should now be your topmost view controller
//
//                            }
                              
//                            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
//                                MDCSnackbarManager.setPresentationHostView(window)
//                            }
                        
                        }

                    } catch {
                        
                        if !(endPoint.configurations?.handleNetworkErrorsManually ?? false) {
                       //     SnackBar.showMessage(response.error?.localizedDescription)
                        }
                        failure?(nil, response.error)
                       print(response.error ?? "")
                    }
                    
                   }
   
    }

}
//func showCustomeAlert(_ ViewController: UIViewController, messageA:String, MessageColor:String){
//        let message = MDCSnackbarMessage()
//        message.text = messageA
//        let myColors: [String: UIColor] = [
//            "red": .red,
//            "white": .white,
//            "green" : UIColor.init(red: 70/255, green: 190/255, blue: 104/255, alpha: 1),
//            "gray" : .gray
//        ]
//        MDCSnackbarMessageView.appearance().snackbarMessageViewBackgroundColor = myColors[MessageColor]
//        MDCSnackbarManager.show(message)
//
//
//    }
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
