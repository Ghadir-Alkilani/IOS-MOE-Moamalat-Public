//
//  SentViewModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 17/01/1443 AH.
//

import UIKit

class SentViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var SentModel = [SentResultModel]()
    lazy var sentService = SentInboxService()
    var startLoadingView: (() -> ())?
    var stopLoadingView: (() -> ())?
    var presentTableView: (() -> ())?
    var presentViewController: ((_ vc: UIViewController) -> ())?
    var todayArray : ((_ array: [SentResultModel]) -> ())?
    var weekArray : ((_ array: [SentResultModel]) -> ())?
    var monthArray : ((_ array: [SentResultModel]) -> ())?
    var otherArray : ((_ array: [SentResultModel]) -> ())?
    
    var reloadTableView : (()->())?
    var refreshControl: (() -> ())?
    
    // MARK: - API Calling
    
    func getTodayInbox(Model : SendCorrespondenceModel)  {
        
        startLoadingView?()
        sentService.getSentInbox(model: Model,  success: { [self] (response) in
            
         
            guard let responseArray = response as?[Any] else { return}
            print(responseArray)
            
            self.SentModel = responseArray.map({ (SentResultModel(from: $0) ?? SentResultModel())})
            self.todayArray?(SentModel)
            self.reloadTableView?()
            self.stopLoadingView?()
            self.refreshControl?()
        }) {  [ weak self] (response, error) in
            self?.stopLoadingView?()
            self?.reloadTableView?()
        }
        
    }
    
    func getWeekInbox(Model : SendCorrespondenceModel)  {
    
        startLoadingView?()
        sentService.getSentInbox(model: Model,  success: { [self] (response) in
        
            guard let responseArray = response as?[Any] else { return}
            print(responseArray)
            
            self.SentModel = responseArray.map({ (SentResultModel(from: $0) ?? SentResultModel())})
            self.weekArray?(SentModel)
            self.reloadTableView?()
            self.stopLoadingView?()
            self.refreshControl?()
        }) { [self] (response, error) in
            stopLoadingView!()
            self.reloadTableView?()
        }
    }
    
    func getMonthInbox(Model : SendCorrespondenceModel)  {
        
        startLoadingView?()
        sentService.getSentInbox(model: Model,  success: { [self] (response) in
        
            guard let responseArray = response as?[Any] else { return}
           // print(responseArray)
            self.SentModel = responseArray.map({ (SentResultModel(from: $0) ?? SentResultModel())})
            self.monthArray?(SentModel)
            self.reloadTableView?()
            self.stopLoadingView?()
            self.refreshControl?()
        }) { [weak self] (response, error) in
            self?.stopLoadingView?()
            self?.reloadTableView?()
        }
        
    }
    
    func getOtherInbox(Model : SendCorrespondenceModel)  {
        
        startLoadingView?()
        sentService.getSentInbox(model: Model,  success: { [self] (response) in
            
            guard let responseArray = response as?[Any] else { return}
            
            self.SentModel = responseArray.map({ (SentResultModel(from: $0) ?? SentResultModel())})
            self.otherArray?(SentModel)
            self.reloadTableView?()
            self.stopLoadingView?()
            self.refreshControl?()
        }) { [weak self] (response, error) in
            self?.stopLoadingView?()
            self?.reloadTableView?()
        }
        
    }
}
