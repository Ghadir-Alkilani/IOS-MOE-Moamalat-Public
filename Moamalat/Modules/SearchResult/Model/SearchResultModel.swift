//
//  SearchResult.swift
//  Moamalat
//
//  Created by Ghadir kilani on 26/12/1442 AH.
//



import Foundation
class SearchResultModel : BaseModel , Decodable{
    var displayCorrespondenceId : String?
    var correspondenceDate : String?
    var status : String?
    var hasAccess  : Bool?
    var correspondenceSubject  : String?
    var correspondenceTypeId : Int?
    var correspondenceId : String?
    var correspondenceTypeName : String?
    var destinationName : String?
  
}
