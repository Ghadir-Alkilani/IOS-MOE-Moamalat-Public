//
//  DateMonth.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import Foundation

class DayMonthService: BaseService {
    
    func getDayMonth(success: APISuccess,
                    failure: APIFailure) {
  
        let conf = APIConfiguration(handleErrorsManually: false, handleNetworkErrorsManually: false, handleNetworkActivityIndicatorManually: false, handleResponseModelManually: true, handleActivityIndicatorManually: true)
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: ["op": OP.ServerDateOP], configurations:conf)
      
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
   
       
}
}
