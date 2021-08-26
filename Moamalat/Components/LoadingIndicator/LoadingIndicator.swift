//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/12/1442 AH.
//


import UIKit
import Lottie
import SwiftyGif
class LoadingIndicator: NSObject {

    static var loadingWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    static let shared: LoadingIndicator = {
        return LoadingIndicator()
    }()
    

        static var activityIndicator: AnimationView = {
            
            return activityIndicatorAnimationView()
        }()

       
    // MARK: - Loading Indicator

        class func activityIndicatorAnimationView(fileName: String = "moe_loader.gif") -> AnimationView {
            
            let animationView = AnimationView(animation: Animation.named(fileName))
            animationView.backgroundBehavior = .pauseAndRestore
            animationView.loopMode = .loop
            return animationView
        }
        
        class func showActivityIndicator() {
            
            hideActivityIndicator()
        
            let fileName = "moe_loader.gif"
            activityIndicator = activityIndicatorAnimationView(fileName: fileName)
            
            activityIndicator.play()
            
            activityIndicator.frame = UIScreen.main.bounds
            
            loadingWindow = UIWindow(frame: UIScreen.main.bounds)
            loadingWindow?.makeKeyAndVisible()
            loadingWindow?.addSubview(activityIndicator)
//            let tap = UITapGestureRecognizer(target: self, action: #selector(hideActivityIndicator()))
//            tap.numberOfTapsRequired = 2
//            loadingWindow?.addGestureRecognizer(tap)

            /* Will be uncommented to hanlde loading indicators
             
            if var currentVC = UIViewController.topMostViewController() {

                if let presenetingVC = currentVC.presentingViewController, currentVC.isBeingDismissed {
                    currentVC = presenetingVC
                }

                activityIndicator.frame = currentVC.view.bounds
                currentVC.view.addSubview(activityIndicator)
            } else {

                activityIndicator.frame = UIScreen.main.bounds
                UIApplication.shared.keyWindow?.addSubview(activityIndicator)
            }
             
            */
        }
        
        class func hideActivityIndicator() {
            
            loadingWindow = nil
            activityIndicator.stop()
            activityIndicator.removeFromSuperview()
        }
    
    // MARK: - Network Activity Indicator
    
//    class func showNetworkActivityIndicator() {
//
////        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//
//    class func hideNetworkActivityIndicator() {
//
//   //    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//    @objc func doubleTapped() {
//
//         cancelAllRequests()
//    }
    
}
