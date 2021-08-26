//
//  publicInboxService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 08/12/1442 AH.
//

import Foundation

class PublicInboxService: BaseService {
    
    func getpublicInbox(success: APISuccess,
                    failure: APIFailure) {
    //    getHttpHeaders(op: "87")
      // let parameters: [String : Any] = ["op": API.GetDayMonth]
        let conf = APIConfiguration(handleResponseModelManually: false)
       
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: ["op":"80"] , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
