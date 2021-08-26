//
//  String+Localization.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/12/1442 AH.
//

import Foundation

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, comment: self)
    }
    
    func localized(fromTable tableName: String) -> String {
    
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: self, comment: self)
    }
}
