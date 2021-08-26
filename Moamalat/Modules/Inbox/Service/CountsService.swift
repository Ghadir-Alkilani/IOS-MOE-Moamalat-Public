//
//  CountsService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 24/12/1442 AH.
//

import Foundation

class CountsService: BaseService {
    
    func getCounts(success: APISuccess,
                    failure: APIFailure) {
    //    getHttpHeaders(op: "87")
      // let parameters: [String : Any] = ["op": API.GetDayMonth]
        let conf = APIConfiguration(handleResponseModelManually: true)
       
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: ["op":"77"] , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
