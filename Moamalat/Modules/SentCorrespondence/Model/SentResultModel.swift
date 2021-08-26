//
//  SentResultModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 17/01/1443 AH.
//

import Foundation
class SentResultModel: BaseModel , Codable {
    var displayNumber : Int?
    var correspondenceDate : String?
    var printFH : Int?
    var correspondenceNumber : Int?
    var correspondenceType : Int?
    var correspondenceSubject : String?
    var correspondenceRowNo : Int?
    var correspondenceTypeName : String?
    var correspondenceHijriYear : String?
}

