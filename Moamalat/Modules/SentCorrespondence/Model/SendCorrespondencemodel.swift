//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 16/01/1443 AH.
//

import Foundation
class SendCorrespondenceModel: BaseModel, Codable {
    var sentCorrespondencesPeriod : Int?
    var fromDate : String?
    var toDate : String?
    var isSent : Bool?
}

