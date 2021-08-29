//
//  AttachmentViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/01/1443 AH.
//

import Foundation

class AttachmentViewModel: BaseViewModel  {
    
    // MARK: - Variables
    
    var arr = [AttachmentDetails]()
    var attachmentModel = [AttachmentDetails]()
    lazy var Service = AttachmentService()
    var CorresModel = [CreateCorrespondenceModel]()
    var attachArray : ((_ array: [AttachmentDetails]) -> ())?
    var reloadTableView : (()->())?
    
    // MARK: - API Calling
    
    func addAttachment(Model: AttachmentModel)  {
        
        LoadingIndicator.showActivityIndicator()
        Service.addAttachment(Model: Model, success: { [self] (response) in
    

            guard let responseArray = response as? [String : Any] else {
                    print("noononononono")
                    return}
            let obj = AttachmentDetails.init()
            let fileName = (response as AnyObject).value(forKey:"fileName")
            let size = (response as AnyObject).value(forKey:"size")
            let modificationDate = (response as AnyObject).value(forKey:"modificationDate")
            let versionNo = (response as AnyObject).value(forKey:"versionNo")
            let filenetDocumentId = (response as AnyObject).value(forKey:"filenetDocumentId")
            let modifiedBy = responseArray["modifiedBy"] as! String
            obj.fileName = fileName as? String
            obj.modifiedBy = modifiedBy
            obj.modificationDate = modificationDate as? String
            obj.size = size as? String
            obj.versionNo = versionNo as? String
            obj.filenetDocumentId = filenetDocumentId as? String
            self.attachmentModel.append(obj)
            self.reloadTableView?()
            attachArray?(attachmentModel)
            
        }, failure: nil)
        
    }
    func downloadAttachment(filenetDocumentId: String)  {
        
        LoadingIndicator.showActivityIndicator()
        Service.downloadAttachment(filenetDocumentId: filenetDocumentId, success: {  (response) in
    
            
        }, failure: nil)
        
    }

}

