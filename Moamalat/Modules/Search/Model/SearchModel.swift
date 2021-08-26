//
//  SearchModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 02/01/1443 AH.
//

import Foundation
class SearchModel : BaseModel , Decodable{
    var correspondenceId : String?
    var correspondenceStatus : Int?
    var correspondenceTypeId : String?
    var deliverDate : Bool?
    var endRow : Int?
    var fromDate : String?
    var hijricYear : Int?
    var incomingExternalNo : String?
    var searchScope : Int?
    var startRow : Int?
    var subject : String?
    var toDate : String?
}
