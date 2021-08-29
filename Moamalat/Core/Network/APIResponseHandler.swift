//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import UIKit
import SnackBar


//Please Check arabic Text and Localize it
class APIResponseHandler: NSObject {
    
    func handleResponse(_ responseModel: APIResponseModel, configurations: APIConfiguration? = nil, success: APISuccess, failure: APIFailure) {
        
        if responseModel.errorCode == ErrorCodes.SuccessErrorCode {
            
            let data = responseModel.out?.value
            print(data!)
            success?(data)
            
        }
        
        else if responseModel.errorCode == ErrorCodes.ExpireToken{
            
            if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message: "the_session_has_expire".localized, duration: .lengthLong).show()
            let someDelegate = UIApplication.shared.delegate
            let appDelegate =  someDelegate as! AppDelegate
            appDelegate.restartApp()
            let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
            
            failure?(error, nil)
            }
        } else if responseModel.errorCode == ErrorCodes.NoData{
            
            if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message:"no_results".localized, duration: .lengthLong).show()
            }
            let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
            
            failure?(error, nil)
            
        }else if responseModel.errorCode == ErrorCodes.SystemError{
            if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message: "an_unexpected_error_occurred".localized, duration: .lengthLong).show()
                let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
                
                failure?(error, nil)
            }
        } else if responseModel.errorCode == ErrorCodes.UsernamePasswordNotValid{
            if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message:"the_username_or_password_is_incorrect".localized,
                                 duration: .lengthLong).show()
            }
            let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
            
            failure?(error, nil)
            
        } else if responseModel.errorCode == ErrorCodes.LoggedUserOrPasswordNotPassed{
            if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message: "username_or_password_not_passed".localized,
                                 duration: .lengthLong).show()
            }
            let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
            
            failure?(error, nil)
            
        }else {
            
            let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
            
            failure?(error, nil)
        }
    }
}

