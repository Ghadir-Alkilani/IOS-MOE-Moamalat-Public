//
//  CachingManager.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/12/1442 AH.
//

import Foundation

class CachingManager: NSObject {

    class func store(value: Any?, forKey key: String) {
        
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func removeValue(forKey key: String) {
        
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    class func getValue(forKey key: String) -> Any? {
        
        return UserDefaults.standard.value(forKey: key)
    }
    
    class func token() -> String? {
        
        return CachingManager.getValue(forKey: CachingKeys.Token) as? String
    }
    class func maxScope() -> String? {
        
        return CachingManager.getValue(forKey: CachingKeys.maxScope) as? String
    }
  
    class func startRow() -> Int? {
        
        return CachingManager.getValue(forKey: CachingKeys.startRow) as? Int
    }
    class func endRow() -> Int? {
        
        return CachingManager.getValue(forKey: CachingKeys.endRow) as? Int
    }
    
}
