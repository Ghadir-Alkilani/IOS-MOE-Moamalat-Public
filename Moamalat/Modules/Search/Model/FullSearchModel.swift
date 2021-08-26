//
//  FullSearchModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/01/1443 AH.
//

import Foundation
class FullSearchModel : BaseModel , Decodable{
    var searchText : String?
    var findIn : Int?
    var hijricYear : Int?
    var correspondenceType : Int?
    var correspondenceDateType : Int?
    var forwardingDateType : Int?
    var fromDate : String?
    var toDate : String?
    var forwardingFromDate : String?
    var forwardingToDate : String?
}
