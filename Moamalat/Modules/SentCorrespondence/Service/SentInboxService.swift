//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 17/01/1443 AH.
//

import Foundation
class SentInboxService: BaseService {
    
    func getSentInbox( model : SendCorrespondenceModel,success: APISuccess,
                    failure: APIFailure) {
   
        var  header = [String:String]()
       
        
        let conf = APIConfiguration(handleResponseModelManually: false)

           header = ["op":"118" ,
                     "sentCorrespondencesPeriod":"\(model.sentCorrespondencesPeriod ?? 0)",
                     "fromDate": model.fromDate ?? "" ,"isSent": "\(model.isSent ?? true)"]
       
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.headers)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
