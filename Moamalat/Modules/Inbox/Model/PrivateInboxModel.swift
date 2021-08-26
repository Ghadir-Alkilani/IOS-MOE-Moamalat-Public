//
//  PrivateInboxModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 08/12/1442 AH.
//


import Foundation
class PrivateInboxModel: BaseModel , Decodable{
    
    var correspondenceId  : String?
    var correspondenceTypeId : Int?
    var displayCorrespondenceId : String?
    var fromUser : String?
    var correspondenceTypeName : String?
    var importanceColor : String?
    var locked : Bool?
    var lockedBy : String?
    var lockedBySameUser : Bool?
    var publicInboxDepID : Int?
    var queueName : String?
    var read : Bool?
    var receivedOnHijriDate : String?
    var receivedOnHijriDateNum : Int?
    var stepType : Int?
    var subject : String?
    var userId : Int?
    var userName : String?
    var wobNum : String?
}
      

