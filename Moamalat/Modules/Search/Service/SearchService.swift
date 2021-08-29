//
//  SearchService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/12/1442 AH.
//

import Foundation
class SearchService: BaseService {
    
    func getCorrespondanceInfoFromBarcode(code: String ,success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op": OP.BarcodeOP ,"barcode":code]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func getType(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op": OP.TypeOP]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func getScope(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":OP.ScopeOP]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func getStatus(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":OP.StatusOP]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func getMaxSearchScope(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: true)
        let header = ["op":OP.MaxScopeOP]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getSearchResult(searchModel : SearchModel  , success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":OP.SearchOP]
        let parameters: [String : Any] = ["correspondenceId": searchModel.correspondenceId ?? "",
                                          "correspondenceStatus": searchModel.correspondenceStatus ?? 0,
                                          "correspondenceTypeId": searchModel.correspondenceTypeId ?? "",
                                          "deliverDate": searchModel.deliverDate ?? false,
                                          "endRow": searchModel.endRow ?? "",
                                          "fromDate": searchModel.fromDate ?? "",
                                          "hijricYear": searchModel.hijricYear ?? "",
                                          "incomingExternalNo": searchModel.incomingExternalNo ?? "",
                                          "searchScope": searchModel.searchScope ?? "",
                                          "startRow": searchModel.startRow ?? "",
                                          "subject": searchModel.subject ?? "",
                                          "toDate": searchModel.toDate ?? ""
        ]
       print(parameters)
        let endPoint = EndPoint(method: .post, parameters: parameters  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func getFullSearchResult(searchModel : FullSearchModel  , success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op": OP.FullSearchOP]
        let parameters: [String : Any] = [
            "searchText": searchModel.searchText!,
            "findIn": searchModel.findIn!,
            "hijricYear": searchModel.hijricYear!,
            "correspondenceType": searchModel.correspondenceType! ,
            "correspondenceDateType": searchModel.correspondenceDateType! ,
            "forwardingDateType": searchModel.forwardingDateType!,
            "fromDate": searchModel.fromDate ?? "" ,
            "toDate": searchModel.toDate ?? "" ,
            "forwardingFromDate": searchModel.forwardingFromDate ?? "",
            "forwardingToDate": searchModel.forwardingToDate ?? ""
                                         
        ]
       print(parameters)
        let endPoint = EndPoint(method: .post, parameters: parameters  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getAutocomplete(Model : AutoCompleteModel  , success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"120"]
        let parameters: [String : Any] = [
            "searchText": Model.searchText!,
            "findIn": Model.findIn!,
            "searchIn": Model.searchIn!
        ]
       print(parameters)
        let endPoint = EndPoint(method: .post, parameters: parameters  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
}
