//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/01/1443 AH.
//

import Foundation
class CreateCorrespondenceModel: BaseModel, Decodable {
    var categoryId : Int?
    var confidentialityId : Int?
    var subject : String?
    var typeId : Int?
    var remarks : String?
    var correspondenceDate : String?
    var attachments : String?
    var actionPageSource : Int?
}
