//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//


import UIKit

class LoginViewModel: BaseViewModel  {
    
    // MARK: - Variabels
    
    var loginModel: LoginModel?
    lazy var service = LoginService()
    lazy var getDayMonthService = DayMonthService()
    var presentViewController: ((_ vc: UIViewController) -> ())?
    var startLoadingView: (() -> ())?
    var stopLoadingView: (() -> ())?

    
    // MARK: - API Calling
    
    func loginandEncrypt(_ userName:String? , _ password:String?)  {
        
        startLoadingView?()
        getDayMonthService.getDayMonth(success: { [weak self] (response) in
           
           guard  let response = (response as AnyObject).value(forKey:"value") else {return}
            print(response)
          
            let key  =  response as! String + EncryptionKeys.key
            let CipherCode = Cipher.init(key: key)
            let passwordBase64String = password?.data(using: .utf8)
            let passwordCipherEncypt = CipherCode?.encrypt(passwordBase64String)
            let passwordFinal = passwordCipherEncypt?.base64EncodedString()
            self?.service.login(userName: userName, password:passwordFinal , success: { (response) in
                
           self?.loginModel = LoginModel(from: response)
                guard  let token = (response as AnyObject).value(forKey:"token") else {return}
                CachingManager.store(value: token, forKey: CachingKeys.Token)
                  print(token)
                let storyboard = UIStoryboard(name: "Inbox", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self?.stopLoadingView?()
                self?.presentViewController?(vc)
                //LoadingIndicator.hideActivityIndicator()

            }, failure: nil)
            
        }) { (errro, error) in
            print(error!)
          
            self.stopLoadingView?()
        }
        
    }
    
}
