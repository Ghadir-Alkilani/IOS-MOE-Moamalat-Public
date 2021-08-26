////
////  SnackBar.swift
////  Moamalat
////
////  Created by Ghadir kilani on 05/12/1442 AH.
////
//
//import UIKit
//import TTGSnackbar
//
//enum SnackBarDuration: Int {
//    
//    case short = 1
//    case middle = 3
//    case long = 5
//    case forever = 2147483647 // Must dismiss manually.
//}
//
//class SnackBar: NSObject {
//
//    
//    // MARK: - Initialization
//
//    lazy var snackBar = TTGSnackbar()
//    
//    static let shared: SnackBar = {
//        let sharedInstance = SnackBar()
//        sharedInstance.setup()
//        return sharedInstance
//    }()
//    
//    
//    // MARK: - Setup
//    
//    func setup() {
//
//        snackBar.shouldDismissOnSwipe = true
//        snackBar.messageTextAlign = LanguageManager.manager.currentLanguage == .en ? .left : .right
//        snackBar.messageTextFont = UIFont.systemFont(ofSize: 18)
//    }
//    
//    
//    // MARK: - SnackBar
//
//    class func dismiss() {
//        
//        shared.snackBar.dismiss()
//    }
//    
//    class func showMessage(_ msg: String?, duration: SnackBarDuration = .long) {
//        
//        guard let msg = msg, !msg.isEmpty else { return }
//        
//        SnackBar.dismiss()
//        
//        shared.snackBar = TTGSnackbar(message: msg, duration: snackBarDuration(for: duration))
//        shared.setup()
//        shared.snackBar.show()
//    }
//    
//    class func snackBarDuration(for duration: SnackBarDuration) -> TTGSnackbarDuration {
//        
//        return TTGSnackbarDuration(rawValue: duration.rawValue) ?? .long
//    }
//}
