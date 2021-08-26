//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 07/12/1442 AH.
//

import UIKit

extension Encodable {

    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        
        do {
            let data = try encoder.encode(self)
            let object = try JSONSerialization.jsonObject(with: data) as? [String : Any]
                        
            return object
            
        } catch {
            
            return nil
        }
    }
}
