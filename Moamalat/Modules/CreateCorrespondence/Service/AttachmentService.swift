//
//  AttachmentService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/01/1443 AH.
//

import Foundation

class AttachmentService: BaseService {
    
    func addAttachment(Model : AttachmentModel  , success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: true)
        let header  = ["op":"7" ,"correspondenceId":"\(Model.correspondenceId ?? "")",
                       "correspondenceTypeId":"\(Model.correspondenceTypeId ?? 0 )"]
        
        let parameters: [String : Any] = ["mimType": Model.mimType ?? "",
                                          "fileContentEncoded": Model.fileContentEncoded ?? "",
                                          "documentTitle": Model.documentTitle ?? "",
                                          "fileName": Model.fileName ?? ""
        ]
       print(parameters)
        print(header)
        
        let endPoint = EndPoint(method: .post, parameters: parameters  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func downloadAttachment(filenetDocumentId : String  , success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: true)
        let header  = ["filenetDocumentId":filenetDocumentId]
        let parameters: [String : Any] = ["docPassword": "" ]
        print(header)
        
        let endPoint = EndPoint(method: .post, parameters: parameters  , headers: header , configurations: conf , fullURL: "http://200.200.200.156:9080/MOAMALAT-ICN-WS/DownloadDocument")
    
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    
}
