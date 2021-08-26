//
//  main.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/12/1442 AH.
//

import Foundation
import UIKit

class MyApplication: UIApplication {
    override init() {
     
         let notFirstOpenKey = "notFirstOpen"
         let notFirstOpen = UserDefaults.standard.bool(forKey: notFirstOpenKey)
         if notFirstOpen == false {
         UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
         UserDefaults.standard.set(true, forKey: notFirstOpenKey)
       
    }
        super.init()
    }
}
UIApplicationMain(
    CommandLine.argc,
   CommandLine.unsafeArgv,
   NSStringFromClass(MyApplication.self),
  NSStringFromClass(AppDelegate.self)
)
