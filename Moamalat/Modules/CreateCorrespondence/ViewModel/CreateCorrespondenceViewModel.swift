//
//  CreateCorrespondenceViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/01/1443 AH.
//

import Foundation
class CreateCorrespondenceViewModel: BaseViewModel  {
    
    //MARK: - Variables
    
var dropDownModel = [DropDownModel]()
lazy var service = SearchService()
lazy var createService = CreateCorrespondenceService()
var presentViewController: ((_ vc: UIViewController) -> ())?
var categoryArray : ((_ array: [DropDownModel]) -> ())?
var confidentialtyArray : ((_ array: [DropDownModel]) -> ())?
var typeArray : ((_ array: [DropDownModel]) -> ())?
var corresModel = [CreateCorrespondenceModel]()

    
    // MARK: - API Calling
    
func getType()  {
    
    LoadingIndicator.showActivityIndicator()
    
    createService.getType( success: { [self] (response) in
        
        guard let responseArray = response as?[Any] else { return}
        self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
        self.typeArray?(dropDownModel)
    }, failure: nil)
    
}

func getCategory()  {
    
    LoadingIndicator.showActivityIndicator()
    
    createService.getCategory( success: { [self] (response) in
        
        guard let responseArray = response as?[Any] else { return}
        self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
        self.categoryArray?(dropDownModel)

    }, failure: nil)
    
}

func getConfidentialty()  {
    
    LoadingIndicator.showActivityIndicator()
    
    createService.getConfidentialty(success: { [self] (response) in
    
        guard let responseArray = response as?[Any] else { return}
        self.dropDownModel = responseArray.map({ (DropDownModel(from: $0) ?? DropDownModel())})
        self.confidentialtyArray?(dropDownModel)

    }, failure: nil)
    
}
    func createCorrespondance(createModel : CreateCorrespondenceModel)  {
        
        LoadingIndicator.showActivityIndicator()
        
        createService.createCorrespondence(createModel : createModel , success: { [self] (response) in
  
            guard let responseArray = response as? [Any] else { return}
            self.corresModel = responseArray.map({ (CreateCorrespondenceModel(from: $0) ?? CreateCorrespondenceModel())})
    
            let vc = AttachmentViewController.initializeFromStoryboard()
           vc.viewModel.CorresModel = corresModel
               self.presentViewController?(vc)

        }, failure: nil)
        
    }

}
