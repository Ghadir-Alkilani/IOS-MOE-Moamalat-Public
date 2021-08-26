//
//  AttachmentViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/01/1443 AH.
//

import Foundation
class AttachmentViewModel: BaseViewModel  {
    var arr = [AttachmentDetails]()
   var attachmentModel = [AttachmentDetails]()
    lazy var Service = AttachmentService()
    var CorresModel = [CreateCorrespondenceModel]()
    var attachArray : ((_ array: [AttachmentDetails]) -> ())?
    var reloadTableView : (()->())?
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
        Service.downloadAttachment(filenetDocumentId: filenetDocumentId, success: { [self] (response) in
    

            guard let responseArray = response as? [String : Any] else {
                    print("noononononono")
                    return}
//            let obj = AttachmentDetails.init()
//            let fileName = (response as AnyObject).value(forKey:"fileName")
//            let size = (response as AnyObject).value(forKey:"size")
//            let modificationDate = (response as AnyObject).value(forKey:"modificationDate")
//            let versionNo = (response as AnyObject).value(forKey:"versionNo")
//
//            let modifiedBy = responseArray["modifiedBy"] as! String
//            obj.fileName = fileName as? String
//            obj.modifiedBy = modifiedBy
//            obj.modificationDate = modificationDate as? String
//            obj.size = size as? String
//            obj.versionNo = versionNo as? String
//            self.attachmentModel.append(obj)
//            self.reloadTableView?()
//            attachArray?(attachmentModel)
            
        }, failure: nil)
        
    }

}

//label.text = corresAttObject.documentTitle;
//senderVal.text = corresAttObject.modifiedBy;
//dateVal.text = corresAttObject.modificationDate;
//versionVal.text = corresAttObject.attachmentVersion;
//sizeVal.text = corresAttObject.size;
//            let myArray = responseArray.reduce([Int: String]()) { (dict, person) -> [Int: String] in
//                var dict = dict
//             //   dict[person.position] = person.name
//                return dict
//
//
//            }
//            let arr = responseArray.map { "\($0.key)  \($0.value)" }
//            let array = Array(responseArray.keys.map { "\($0) \(responseArray[$0]!)" })
//            print(array)

//  print(arrayOfValues) // [a, b, c]        let arara = responseArray.map({ [String: Any](from: $0) ?? [String: Any]())})
// self.attachArray?(responseArray)
//   guard  let token = (response as AnyObject).value(forKey:"token") else {return}



//            print(responseArray)
//            print(responseArray)
