//
//  FilterViewModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 02/01/1443 AH.
//

import Foundation
class FilterViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var searchResultModel = [SearchResultModel]()
    var dropDownModel = [DropDownModel]()
    var searchModel = [SearchModel]()
    lazy var service = SearchService()
    var scopeArray : ((_ array: [DropDownModel]) -> ())?
    var statusArray : ((_ array: [DropDownModel]) -> ())?
    var typeArray : ((_ array: [DropDownModel]) -> ())?
    var presentViewController: ((_ vc: UIViewController) -> ())?
    
    // MARK: - API Calling
    
   func getType()  {
    
    LoadingIndicator.showActivityIndicator()
    
    service.getType( success: { [self] (response) in
        
        guard let responseArray = response as?[Any] else { return}
        self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
        self.typeArray?(dropDownModel)
    }, failure: nil)
    
}

func getScope()  {
    
    LoadingIndicator.showActivityIndicator()
    
    service.getScope( success: { [self] (response) in
    
        guard let responseArray = response as?[Any] else { return}
        self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
        self.scopeArray?(dropDownModel)

    }, failure: nil)
    
}
    func getFullSearchResult(search:FullSearchModel)  {
        
        LoadingIndicator.showActivityIndicator()
        
        service.getFullSearchResult(searchModel: search,success: { [self] (response) in
   
            guard let responseArray = response as?[Any] else { return}
            self.searchResultModel = responseArray.map({ (SearchResultModel(from: $0) ?? SearchResultModel())})
          
            let VC = SearchResultViewController.initializeFromStoryboard()
     
            let navigationController = UINavigationController(rootViewController: VC)
            navigationController.modalPresentationStyle = .overFullScreen
    
            VC.viewModel.searchResultModel = searchResultModel
            LoadingIndicator.hideActivityIndicator()
            self.presentViewController?(navigationController)

        }, failure: nil)
        
    }

}
