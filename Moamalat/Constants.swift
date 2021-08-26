//
//  Constants.swift
//  Moamalat
//
//  Created by Ghadir kilani on 01/12/1442 AH.
//

import Foundation

enum LocalizationConstants {
    
    static let AppleLanguages = "AppleLanguages"
    
}

enum BaseURL {
    
    static let test = "http://213.165.36.130:9080/MOAMALAT-WS/MoamalatJSON"
    static let staging = "http://213.165.36.130:9080/MOAMALAT-WS/MoamalatJSON"
    static let production = "http://213.165.36.130:9080/MOAMALAT-WS/MoamalatJSON"
}

enum ErrorCodes {
    
    static let SuccessErrorCode = "0"
    static let ExpireToken = "57"
    static let NoData = "20"
    static let SystemError = "-1"
    static let UsernamePasswordNotValid = "1"
    static let LoggedUserOrPasswordNotPassed = "2"
}

enum Storyboards {
    
    static let Login = "Login"
    static let Inbox = "Inbox"
    static let PublicInbox = "PublicInbox"
    static let SearchResult = "SearchResult"
    static let Search = "Search"
    static let Logout = "Logout"
    static let FilterFullSearch = "FilterFullSearch"
    static let CreateCorrespondence = "CreateCorrespondence"
    static let SentCorrepondence = "SentCorrepondence"
  
}

enum API {
    
    static let Login = "1"
    static let GetDayMonth = "87"
    
}

enum HTTPErrorCode {
    
    static let authorization = 401
}

enum EncryptionKeys {
    
    static let key = "$mobile$P@$$W0RD"
}

enum Role {
    
    static let DirectorOfTheFollowUpUnit = 1
    static let DirectorOfTheMonitoringUnit = 2
    static let FollowUpUnitEmployee = 3
    static let ReferralManager = 4
    static let RepresentativeOfTheReferringAuthority = 5
}

enum CachingKeys {

    static let Token = "Token"
    static let FirstTimeUse = "FirstTimeUse"
    static let maxScope = "maxScope"
    static let hasInboxAccess = "hasInboxAccess"
    static let language = "language"
    static let IsExpireToken = "isExpireToken"
    static let startRow = "startRow"
    static let endRow =  "endRow"
    
}

enum Fonts {
    
    static let DINNextLTArabicBlack = "DINNextLTArabic-Black"
    static let DINNextLTArabicBold = "DIN Next LT Arabic Bold"
    static let DINNextLTArabicLight = "DIN NextLTArabic-Light"
    static let DINNextLTArabicMedium = "DIN Next LT Arabic Medium"
    static let DINNextLTArabicRegular = "DINNextLTArabic-Regular"
    static let DINNextLTArabicUltraLigh = "DINNextLTArabic UltraLigh"
    static let JFFlatRegular = "JF Flat Regular"
  
}

