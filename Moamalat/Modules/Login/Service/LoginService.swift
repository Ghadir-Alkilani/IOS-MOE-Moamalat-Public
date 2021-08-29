//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import UIKit

class LoginService: BaseService {
    
    func login(userName: String?,
               password: String?,
               success: APISuccess,
               failure: APIFailure) {
        
        let parameters: [String : Any] = ["username": userName ?? "",
              "password": password ?? ""]
        let conf = APIConfiguration(handleErrorsManually: false, handleNetworkErrorsManually: false, handleNetworkActivityIndicatorManually: false, handleResponseModelManually: true, handleActivityIndicatorManually: true)
        
        let endPoint = EndPoint( method: .post, parameters: parameters, headers: ["op" : OP.LoginOP ] ,configurations: conf)
 print(endPoint)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
