//
//  LoadingView.swift
//  Moamalat
//
//  Created by Ghadir kilani on 06/01/1443 AH.
//

import UIKit
import Alamofire
import SwiftyGif
class loadingView: UIView {
    var activityIndicator = UIActivityIndicatorView()
   // var messageView = MessageView()
     /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
         
        
    }
 */
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.init(hexString: "000000", alpha: 0.5)
        let loadView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 70))
        loadView.backgroundColor = .clear
        loadView.layer.cornerRadius = 15
        // actitvity
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = CGPoint(x: loadView.center.x, y: 15)
        activityIndicator.style = .white
        activityIndicator.color = .black
//        loadView.addSubview(activityIndicator)
        // label
        let label = UILabel(frame: CGRect(x: 0, y: 40, width:loadView.frame.size.width , height: 20))
        label.text = "جاري التحميل ..."
        label.textAlignment = .center
        label.font = UIFont.init(name: "GESSTwoMedium-Medium", size: 16)
        label.center = CGPoint(x: loadView.center.x, y: 40)
        
//        loadView.addSubview(label)
        loadView.center = self.center
        do {
        let gif =  try UIImage(gifName: "moe_loader.gif")
        let imageView = UIImageView(gifImage: gif, loopCount: -1) // Will loop 3 times
        //    imageView.frame = CGRect(x:self.center.x, y: self.center.y, width: 150, height: 150)
      //  let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x:0, y: 0, width: 100, height: 100)
        imageView.center = self.center
        self.addSubview(imageView)
//        self.addSubview(loadView)
        }catch{
            print("error")
        }
        let tapped = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tapped.numberOfTapsRequired = 2
        addGestureRecognizer(tapped)
        
 
    }
    @objc func doubleTapped() {
        // do something here
        print("errororojron")
         stopAnimating()
        cancelAllRequests()
    }
    
    // cancel all requests
    func cancelAllRequests(){
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
    func startAnimating(){
        activityIndicator.startAnimating()
    }
    func stopAnimating(){
//        sleep(1)
        activityIndicator.stopAnimating()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
}
//class loadingView: UIView {
//    var activityIndicator = UIActivityIndicatorView()
//    static var loadingView: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
//   // var messageView = MessageView()
//     /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//
//
//    }
// */
//    override init(frame: CGRect) {
//        super.init(frame:frame)
//      self.backgroundColor = UIColor.init(hexString: "000000", alpha: 0.5)
//        let loadView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 70))
//        loadView.backgroundColor = .gray
//        loadView.layer.cornerRadius = 15
//        // actitvity
//        activityIndicator = UIActivityIndicatorView()
//        activityIndicator.center = CGPoint(x: loadView.center.x, y: 15)
//        activityIndicator.style = .white
//        activityIndicator.color = .black
////        loadView.addSubview(activityIndicator)
//        // label
////        let label = UILabel(frame: CGRect(x: 0, y: 40, width:loadView.frame.size.width , height: 20))
////        label.text = "جاري التحميل ..."
////        label.textAlignment = .center
////        label.font = UIFont.init(name: "GESSTwoMedium-Medium", size: 16)
////        label.center = CGPoint(x: loadView.center.x, y: 40)
//        loadView.center = self.center
//
//        do {
//            let gif = try UIImage(gifName: "moe_loader.gif")
//            let imageview = UIImageView(gifImage: gif, loopCount: -1) // Will loop 3 times
//            imageview.frame = CGRect(x:self.center.x, y: self.center.y, width: 150, height: 150)
//            imageview.center = self.center
//           self.addSubview(imageview)
//           // self.addSubview(loadView)
//         //  view.addSubview(imageview)
//        } catch {
//            print(error)
//        }
////        loadView.addSubview(label)
//      //  let jeremyGif = UIImage.gif(name: "moe_loader")
////        let imageView = UIImageView(image: jeremyGif)
////        imageView.frame = CGRect(x:0, y: 0, width: 100, height: 100)
////        imageView.center = self.center
////        self.addSubview(imageView)
////        self.addSubview(loadView)
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
//        tap.numberOfTapsRequired = 2
//        addGestureRecognizer(tap)
//
//
//    }
//    @objc func doubleTapped() {
//        // do something here
//        stopAnimating()
//         cancelAllRequests()
//    }
//
//    // cancel all requests
//    func cancelAllRequests(){
//        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
//            sessionDataTask.forEach { $0.cancel() }
//            uploadData.forEach { $0.cancel() }
//            downloadData.forEach { $0.cancel() }
//        }
//    }
//    func startAnimating(){
//        activityIndicator.startAnimating()
//    }
//    func stopAnimating(){
////        sleep(1)
//        activityIndicator.stopAnimating()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//    }
//
//}
