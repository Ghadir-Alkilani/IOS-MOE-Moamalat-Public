//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 08/12/1442 AH.
//

import UIKit


class InboxViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var publicModel =  [publicInbox]()
    var privateModel = [PrivateInboxModel]()
    var countModel = [CountsModel]()
    lazy var service = PublicInboxService()
    lazy var privateService = PrivateInboxService()
    lazy var countService = CountsService()
    var startLoadingView: (() -> ())?
    var stopLoadingView: (() -> ())?
    var presentViewController: ((_ vc: UIViewController) -> ())?
    var inboxArray : ((_ array: [publicInbox]) -> ())?
    var privateArray : ((_ array: [PrivateInboxModel]) -> ())?
    var delayArray : ((_ array: [PrivateInboxModel]) -> ())?
    var unreadArray : ((_ array: [PrivateInboxModel]) -> ())?
    var CCArray : ((_ array: [PrivateInboxModel]) -> ())?
    var urgentArray : ((_ array: [PrivateInboxModel]) -> ())?
    var importantArray : ((_ array: [PrivateInboxModel]) -> ())?
    var nowArray : ((_ array: [PrivateInboxModel]) -> ())?
    var urgentImportantArray : ((_ array: [PrivateInboxModel]) -> ())?
    var countsDic : ((_ Dic: [String:Any]) -> ())?
    var reloadTableView : (()->())?
    var refreshControl: (() -> ())?

    // MARK: - API Calling
    
    func getpublicInbox()  {
        
        startLoadingView?()
        service.getpublicInbox(success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.publicModel = responseArray.map({ (publicInbox(from: $0) ?? publicInbox())})
               self.inboxArray?(publicModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    
    func getPrivateInbox(isFilter : Bool , startRow : Int , endRow : Int)  {
        
        startLoadingView?()
        privateService.getPrivateInbox(isFilter : isFilter, startRow : startRow , endRow : endRow , success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.privateArray?(privateModel)
           //    print(correspondenceModelsArray)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }) { (any, error) in
            self.stopLoadingView?()
        }
        
    }
    func getDelayInbox()  {
        
        startLoadingView?()
        privateService.getDelayInbox( success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.delayArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    func getUrgentInbox()  {
        startLoadingView?()
        
        privateService.getUrgentInbox( success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.urgentArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    func getImportantInbox()  {
        
        startLoadingView?()
        privateService.getImportantInbox( success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.importantArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    
    func getUrgentImportantInbox()  {
        
        startLoadingView?()
        privateService.getUrgentInbox( success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.importantArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
    }
    
    func getNowInbox()  {
        
        startLoadingView?()
        privateService.getUrgentInbox( success: { [self] (response) in
        guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.nowArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    func getCCInbox()  {
        
        startLoadingView?()
        privateService.getUrgentInbox( success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.CCArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    func getUnreadInbox()  {
        startLoadingView?()
        
        privateService.getUrgentInbox( success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.unreadArray?(privateModel)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    func getCounts() {
        
        startLoadingView?()
        countService.getCounts(success: { [self] (response) in
           
            let halfTimeCount = (response as AnyObject).value(forKey:"halfTimeCount")
            let ccCount = (response as AnyObject).value(forKey:"ccCount")
            let unreadCount = (response as AnyObject).value(forKey:"UnreadCount")
            var dic = [String:Any]()
            dic.updateValue(halfTimeCount ?? 0, forKey: "halfTimeCount")
            dic.updateValue(ccCount ?? 0, forKey: "ccCount")
            dic.updateValue(unreadCount ?? 0, forKey: "UnreadCount")
            
               self.countsDic?(dic)
           print(dic)
               self.reloadTableView?()
            self.stopLoadingView?()
               self.refreshControl?()
        }, failure: nil)
        
    }
    
}
