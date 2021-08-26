//
//  LoginModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import Foundation
import UIKit

class LoginModel: BaseModel, Codable {
    
var VIP: Bool?
var appId: String?
var applicationVersion: Double?
var applicationVersionMsg:  String?
var autocompleteInMaxPermission: Bool?
var currentHijriDate: Int?
var currentYear: Int?
var departmentCode: String?
var departmentName: String?
var displayDate: String?
var errorCode : String?
var forwardToMinister: Bool?
var forwardToMinisterAndViceMinster: Bool?
var forwardToVICEMinister: Bool?
var loggedInUserId : String?
var showMinisterInbox: Bool?
var token: String?
var underMaintenance : Bool?
var underMaintenanceMsg: String?
var userDisplayName: String?
var userPhoto:String?
var vipMinisterPageVersion: String?
    
}
