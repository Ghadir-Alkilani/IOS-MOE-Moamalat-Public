//
//  LanguageManager.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import UIKit

enum Language: String {
    
    case en = "en"
    case ar = "ar"
}

class LanguageManager: NSObject {


    // MARK - Shared Instance
    
    static let manager: LanguageManager = {
        return LanguageManager()
    }()
    
    
    // MARK - Change Language
    
    func setEnglishLanguage() {
        
        setLanguage(lang: .en)
    }
    
    func setArabicLanguage() {
        
        setLanguage(lang: .ar)
    }
    
    func setLanguage(lang : Language) {
        
        UserDefaults.standard.set(lang, forKey: LocalizationConstants.AppleLanguages)
        UserDefaults.standard.synchronize()
    }
    
    
    // MARK - Change Language

    var currentLanguage: Language {
        
        return UIApplication.shared.userInterfaceLayoutDirection == .leftToRight ? .en : .ar
    }
    
    var currentLanguageCode: String {
        
        return currentLanguage.rawValue
    }
    
    var isRTLLanguage: Bool {
        
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

