//
//  DetailsViewModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/01/1443 AH.
//

import UIKit

class DetailsViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var detailsModel = [SentResultModel]()
    lazy var service = DetailsService()
    var startLoadingView: (() -> ())?
    var stopLoadingView: (() -> ())?
    var presentTableView: (() -> ())?
    var presentViewController: ((_ vc: UIViewController) -> ())?
    var todayArray : ((_ array: [SentResultModel]) -> ())?
    var reloadTableView : (()->())?
    var refreshControl: (() -> ())?
    
    // MARK: - API Calling
    
    func getCorrespondenceDetails(correspondenceId: String, correspondenceTypeId: Int, wobNum: String ) {
        
        startLoadingView?()
        service.getCorrespondenceDetails(correspondenceId: correspondenceId, correspondenceTypeId: correspondenceTypeId, wobNum: wobNum,  success: { [self] (response) in
            
         
            guard let responseArray = response as?[Any] else { return}
            print(responseArray)
            
//            self.SentModel = responseArray.map({ (SentResultModel(from: $0) ?? SentResultModel())})
//            self.todayArray?(SentModel)
            self.reloadTableView?()
            self.stopLoadingView?()
            self.refreshControl?()
        }) {  [ weak self] (response, error) in
            self?.stopLoadingView?()
           // self?.reloadTableView?()
        }
        
    }
}
