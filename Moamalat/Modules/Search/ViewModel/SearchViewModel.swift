//
//  SearchViewModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/12/1442 AH.
//

import Foundation
import UIKit


class SearchViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var searchResultModel = [SearchResultModel]()
    var autoCompleteResultModel = [AutoCompleteResultModel]()
    
    var dropDownModel = [DropDownModel]()
    var maxScope = [MaxScope]()
    var searchModel = [SearchModel]()
    lazy var service = SearchService()
    var presentViewController: ((_ vc: UIViewController) -> ())?
    var dismissVC: (() -> ())?
    var searcResultArray : ((_ array: [SearchResultModel]) -> ())?
    var autoCompleteArray : ((_ array: [AutoCompleteResultModel]) -> ())?
    var searchArray : ((_ array: [SearchModel]) -> ())?

    var scopeArray : ((_ array: [DropDownModel]) -> ())?
    var statusArray : ((_ array: [DropDownModel]) -> ())?
    var typeArray : ((_ array: [DropDownModel]) -> ())?
    var maxArray : ((_ array: [MaxScope]) -> ())?
    var reloadTableView : (()->())?
    var refreshControl: (() -> ())?
    var startLoadingView: (() -> ())?
    var stopLoadingView: (() -> ())?

    // MARK: - API Calling
    
    func getCorrespondanceInfoFromBarcode(code: String )  {
        
        startLoadingView?()

        service.getCorrespondanceInfoFromBarcode(code: code, success: { [self] (response) in
           
            guard let responseArray = response as?[Any] else { return}
            self.searchResultModel = responseArray.map({ (SearchResultModel(from: $0) ?? SearchResultModel())})
            let VC = SearchResultViewController.initializeFromStoryboard()
            let navigationController = UINavigationController(rootViewController: VC)
            navigationController.modalPresentationStyle = .overFullScreen
            VC.viewModel.searchResultModel = searchResultModel
            self.dismissVC?()
            self.stopLoadingView?()
            self.presentViewController?(navigationController)
             
        }){ (errro, error) in
            print(error!)
          
            self.stopLoadingView?()
        }
    }
    
    func getType()  {
        
        startLoadingView?()

        service.getType( success: { [self] (response) in
            
           // print(response)
            guard let responseArray = response as?[Any] else { return}
            self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
            self.typeArray?(dropDownModel)
            self.stopLoadingView?()

        }, failure: nil)
        
    }
    
    func getScope()  {
        
        startLoadingView?()

        service.getScope( success: { [self] (response) in
            
           // print(response)
            guard let responseArray = response as?[Any] else { return}
            self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
            self.scopeArray?(dropDownModel)
            self.stopLoadingView?()

        }, failure: nil)
        
    }
    
    func getStatus()  {
        
        startLoadingView?()

        service.getStatus(success: { [self] (response) in
            
          //  print(response)
            guard let responseArray = response as?[Any] else { return}
            self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
            self.statusArray?(dropDownModel)

        }, failure: nil)
        self.stopLoadingView?()

    }
    
    func getSearchResult(search:SearchModel)  {
        
        startLoadingView?()
        
        service.getSearchResult(searchModel: search,success: { [self] (response) in
            guard let responseArray = response as?[Any] else { return}
            self.searchResultModel = responseArray.map({ (SearchResultModel(from: $0) ?? SearchResultModel())})
            let VC = SearchResultViewController.initializeFromStoryboard()
            let navigationController = UINavigationController(rootViewController: VC)
            navigationController.modalPresentationStyle = .overFullScreen
          
            VC.viewModel.searchResultModel = searchResultModel
       
            self.stopLoadingView?()
            self.presentViewController?(navigationController)

        }) { (response, error) in
        
            self.stopLoadingView?()

        }
        
    }
    func getMaxSearchScope()  {
        
        LoadingIndicator.showActivityIndicator()
        
        service.getMaxSearchScope(success: {  (response) in
            
         //   print(response)
            guard  let maxScope = (response as AnyObject).value(forKey:"value") else {return}
            CachingManager.store(value: maxScope, forKey: CachingKeys.maxScope)
              print(maxScope)


        }, failure: nil)
        
    }
    
    func getFullSearchResult(search:FullSearchModel)  {
        
        LoadingIndicator.showActivityIndicator()
        
        service.getFullSearchResult(searchModel: search,success: { [self] (response) in
           // print(response)
            guard let responseArray = response as?[Any] else { return}
            self.searchResultModel = responseArray.map({ (SearchResultModel(from: $0) ?? SearchResultModel())})
            //self.searcResultArray?(searchResultModel)
            let VC = SearchResultViewController.initializeFromStoryboard()
           // VC.isHidden = true
            let navigationController = UINavigationController(rootViewController: VC)
            navigationController.modalPresentationStyle = .overFullScreen
          
            VC.viewModel.searchResultModel = searchResultModel
           // self.dismissVC?()
          //  VC.viewModel.passData()
            LoadingIndicator.hideActivityIndicator()
            self.presentViewController?(navigationController)

        }, failure: nil)
    }
        func getAutocomplete(model:AutoCompleteModel)  {
            
            LoadingIndicator.showActivityIndicator()
            
            service.getAutocomplete( Model: model,success: { [self] (response) in
                guard let responseArray = response as?[Any] else { return}
                
         self.autoCompleteResultModel = responseArray.map({ (AutoCompleteResultModel(from: $0) ?? AutoCompleteResultModel())})
                self.autoCompleteArray?(autoCompleteResultModel)
                self.reloadTableView?()
               
                LoadingIndicator.hideActivityIndicator()
   
            }, failure: nil)
            
        
    }
}
