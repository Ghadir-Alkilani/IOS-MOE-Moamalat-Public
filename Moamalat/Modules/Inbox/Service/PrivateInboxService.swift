//
//  PrivateInboxService.swift
//  Moamalat
//
//  Created by Ghadir kilani on 18/12/1442 AH.
//

import Foundation
class PrivateInboxService: BaseService {
    
    func getPrivateInbox(isFilter : Bool, startRow : Int , endRow : Int ,success: APISuccess,
                    failure: APIFailure) {
   
        var  header = [String:String]()
       
        
        let conf = APIConfiguration(handleResponseModelManually: false)
        if isFilter{
      
//            header.updateValue("\(CachingManager.startRow())", forKey: "startRow")
//            header.updateValue("\(CachingManager.endRow())", forKey: "endRow")
            header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"\(startRow)", "endRow":"\(endRow)" , "filterType":"-1"]
            print("scrolled")
        }else{
            let start = 1
            let end = 20
           header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"\(start)", "endRow":"\(end)" , "filterType":"-1"]
        }
       
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getUnreadInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"1"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getDelayInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"6"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getCCInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"7"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getUrgentInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"9"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getImportantInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"8"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    func getUrgentImportantInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"10"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
    }
    
    func getNowInbox(success: APISuccess,
                    failure: APIFailure) {
   
        let conf = APIConfiguration(handleResponseModelManually: false)
        let header = ["op":"29" ,"orderType":"3", "sortType":"2" , "startRow":"1", "endRow":"20" , "filterType":"11"]
        let endPoint = EndPoint(method: .post, parameters: nil  , headers: header , configurations: conf)
        
        print(endPoint.url)
        NetworkManager.manager.request(endPoint: endPoint, success: success, failure: failure)
        
    }
}
