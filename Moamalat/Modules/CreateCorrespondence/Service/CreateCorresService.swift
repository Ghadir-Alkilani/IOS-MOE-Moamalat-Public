//
//  CreateCorresService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/01/1443 AH.
//

import Foundation
class CreateCorrespondenceService: BaseService {
    
    func getType(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"14"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getCategory(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"15"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getConfidentialty(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"16"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func createCorrespondence(createModel : CreateCorrespondenceModel  , success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"3"]
        let parameters: [String : Any] = ["categoryId": createModel.categoryId!,
             "confidentialityId": createModel.confidentialityId!,
                                          "subject": createModel.subject!,
                                          "typeId": createModel.typeId!,
                                          "remarks": createModel.remarks!,
                                          "correspondenceDate": createModel.correspondenceDate!,
                                          "attachments" : createModel.attachments!,
                                          "actionPageSource" : createModel.actionPageSource!
        ]
       print(parameters)
        let endPoint = EndPoint(method: .post, parameters: parameters  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
}
