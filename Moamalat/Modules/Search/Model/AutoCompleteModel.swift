//
//  AutoCompleteModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/01/1443 AH.
//

import Foundation
class AutoCompleteModel: BaseModel , Decodable {
    var findIn : Int?
    var searchText : String?
    var searchIn : String?
}
