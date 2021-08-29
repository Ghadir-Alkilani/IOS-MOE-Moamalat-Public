//
//  Service.swift
//  Moamalat
//
//  Created by Ghadir kilani on 19/12/1442 AH.
//

import Foundation
class PublicPrivInboxService: BaseService {
    
    func getPrivateInbox( queueName : String ,inbasketFilter: String,  success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op": OP.PrivateInboxOP ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"-1" , "queueName":queueName , "inbasketFilter":inbasketFilter]
        
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
