//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import Foundation

class GeneralErrorHandling: BaseModel {
    
    class func handleError(for response: APIResponseModel, configurations: APIConfiguration? = nil) -> Any? {
        
        //        let data = response.payload?.value
        //        let errorType = response.code
        
        if !(configurations?.handleErrorsManually ?? false) {
          //  showErrorMessage(response.otherData)
        }
        
        return response
        
    }
    
    class func showErrorMessage(_ error: String?) {
        
     //   SnackBar.showMessage(error)
        
    }
    
}
