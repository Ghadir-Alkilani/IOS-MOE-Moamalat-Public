//
//  APIResponseModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/12/1442 AH.
//

import Foundation
import AnyCodable

class APIResponseModel: BaseModel, Codable {
    var errorCode: String?
    var out: AnyCodable?


}

