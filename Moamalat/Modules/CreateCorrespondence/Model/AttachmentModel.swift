//
//  AttachmentModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/01/1443 AH.
//

import Foundation

class AttachmentModel: BaseModel, Decodable {
    
    var mimType : String?
    var fileContentEncoded : String?
    var documentTitle : String?
    var fileName : String?
    var correspondenceId : String?
    var correspondenceTypeId : Int?

}
