//
//  Environment.swift
//  Moamalat
//
//  Created by Ghadir kilani on 04/12/1442 AH.
//

import Foundation


#if DEBUG
let environment: Environment = Environment.testing
#else
let environment: Environment = Environment.production
#endif


enum Environment {
    
    case testing
    case production
    
    
    var baseURL: String {
        
        switch self {
            
        case .testing:
            //  static let service_url = ""
   return "http://200.200.200.163:9080/MOAMALAT-ICN-WS/MoamalatJSON" // newURL Comp
   //  return "http://200.200.200.73:9080/MOAMALAT-ICN-WS/DownloadDocument" // newURL Comp
// return "http://213.165.36.130:9080/MOAMALAT-WS/MoamalatJSON"
// return "http://200.200.200.73:9080/MOAMALAT-WS/MoamalatJSON"
        
        case .production:
    // return "http://200.200.200.163:9080/MOAMALAT-ICN-WS/MoamalatJSON" // newURL Comp
//  return "http://213.165.36.130:9080/MOAMALAT-WS/MoamalatJSON"
 return "http://200.200.200.73:9080/MOAMALAT-WS/MoamalatJSON"
        }
    }
    
}
