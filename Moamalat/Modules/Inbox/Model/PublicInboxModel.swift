//
//  PublicInboxModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 08/12/1442 AH.
//

import Foundation
class publicInbox : BaseModel , Decodable{
    var departmentNameAr : String?
    var departmentNameEn : String?
    var errorCode : String?
    var inbasket  : Bool?
    var inbasketFilter  : String?
    var inbasketName : String?
    var queueShortName : String?
    var queueName : String?
    var queueHijriCreateDate : Int?
    //var departmentId : Int?
  
}
