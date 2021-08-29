//
//  AttachmentDetails.swift
//  Moamalat
//
//  Created by Ghadir kilani on 07/01/1443 AH.
//

import Foundation
import PDFKit

class AttachmentDetails: BaseModel, Decodable {
    
    var fileName : String?
    var errorCode : String?
    var modifiedBy : String?
    var size : String?
    var modificationDate : String?
    var versionNo : String?
    var filenetDocumentId : String?
}



