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
       // getHttpHeaders(op: "87")
     //  let parameters: [String : Any] = ["op": API.GetDayMonth]
        let conf = APIConfiguration(handleErrorsManually: false, handleNetworkErrorsManually: false, handleNetworkActivityIndicatorManually: false, handleResponseModelManually: true, handleActivityIndicatorManually: true)
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: ["op":"87"], configurations:conf)
      
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
       // endPoint.configurations?.handleResponseModelManually = false
       print(endPoint.url)
        print(endPoint.headers)
        print(endPoint)
       
}
}
