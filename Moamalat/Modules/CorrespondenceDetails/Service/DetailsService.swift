//
//  DetailsService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/01/1443 AH.
//


import Foundation
class DetailsService: BaseService {
    
    func getCorrespondenceDetails( correspondenceId : String , correspondenceTypeId : Int, wobNum: String ,success: APISuccess,
                    failure: APIFailure) {
   
        var  header = [String:String]()
        let conf = APIConfiguration(handleResponseModelManually: false)

        header = ["op":OP.DetailsOP ,
                     "correspondenceId":correspondenceId,
                     "correspondenceTypeId": "\(correspondenceTypeId)" , "wobNum" : wobNum]
       
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
    
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
