//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//

import UIKit
import SnackBar
class APIResponseHandler: NSObject {
    
    func handleResponse(_ responseModel: APIResponseModel, configurations: APIConfiguration? = nil, success: APISuccess, failure: APIFailure) {
       
        let keyWindow = UIApplication.topViewController()
      //  print(responseModel.errorCode!)
        if responseModel.errorCode == ErrorCodes.SuccessErrorCode {

            let data = responseModel.out?.value
                print(data!)
                success?(data)
            
           
       // CachingManager.store(value: false, forKey: CachingKeys.IsExpireToken)
        //    CachingManager.store(value: true, forKey: CachingKeys.IsExpireToken)

        }
            else if responseModel.errorCode == ErrorCodes.ExpireToken{
                let someDelegate = UIApplication.shared.delegate
                let appDelegate =  someDelegate as! AppDelegate
                appDelegate.restartApp()
              //  success?(data)
                let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
                
                failure?(error, nil)
            } else if responseModel.errorCode == ErrorCodes.NoData{
                print("nodata")
                if let keyWindow = UIApplication.topViewController() {
                    AppSnackBar.make(in: keyWindow.view , message: "عفوا.. لا يوجد نتائج!", duration: .lengthLong).show()
                }
//                let data = responseModel.out?.value
//                   // print(data!)
//                    success?(data)
                let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)

                failure?(error, nil)
    
            }else if responseModel.errorCode == ErrorCodes.SystemError{
                if let keyWindow = UIApplication.topViewController() {
                    AppSnackBar.make(in: keyWindow.view , message: "حدث خطأ غير متوقع، يرجى مراجعة مسؤول النظام", duration: .lengthLong).show()
                    let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
                    
                    failure?(error, nil)
                }
            } else if responseModel.errorCode == ErrorCodes.UsernamePasswordNotValid{
                    if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message:"اسم المستخدم او كلمة السر غير صحيحة",
 duration: .lengthLong).show()
                    }
                let error = GeneralErrorHandling.handleError(for: responseModel, configurations: configurations)
                
                failure?(error, nil)

            } else if responseModel.errorCode == ErrorCodes.LoggedUserOrPasswordNotPassed{
                    if let keyWindow = UIApplication.topViewController() {
                AppSnackBar.make(in: keyWindow.view , message: "اسم المستخدم او الرقم السرى لم يمرر",
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

