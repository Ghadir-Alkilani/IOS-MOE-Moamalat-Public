//
//  PublicViewModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 19/12/1442 AH.
//

import Foundation
import UIKit


class PublicViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var privateModel = [PrivateInboxModel]()
    lazy var service = PublicPrivInboxService()
    var presentViewController: ((_ vc: UIViewController) -> ())?
    var inboxArray : ((_ array: [publicInbox]) -> ())?
    var privateArray : ((_ array: [PrivateInboxModel]) -> ())?
    var reloadTableView : (()->())?
    var refreshControl: (() -> ())?

    // MARK: - API Calling
    
    
    func getPrivateInbox(queueName : String ,inbasketFilter: String )  {
        
        LoadingIndicator.showActivityIndicator()
        
        service.getPrivateInbox(queueName: queueName, inbasketFilter:inbasketFilter , success: { [self] (response) in
           
            //LoadingIndicator.hideActivityIndicator()
           print(response)
            guard let responseArray = response as?[Any] else { return}
              print(responseArray)
              
            self.privateModel = responseArray.map({ (PrivateInboxModel(from: $0) ?? PrivateInboxModel())})
               self.privateArray?(privateModel)
           //    print(correspondenceModelsArray)
               self.reloadTableView?()
               LoadingIndicator.hideActivityIndicator()
               self.refreshControl?()
        }, failure: nil)
        
    }
    
}

