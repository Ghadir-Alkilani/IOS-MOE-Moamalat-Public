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
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.init(hexString: "000000", alpha: 0.5)
        let loadView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 70))
        loadView.backgroundColor = .clear
        loadView.layer.cornerRadius = 15
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = CGPoint(x: loadView.center.x, y: 15)
        activityIndicator.style = .white
        activityIndicator.color = .black
        
        // label
        let label = UILabel(frame: CGRect(x: 0, y: 40, width:loadView.frame.size.width , height: 20))
        label.text = "جاري التحميل ..."
        label.textAlignment = .center
        label.font = UIFont.init(name: "GESSTwoMedium-Medium", size: 16)
        label.center = CGPoint(x: loadView.center.x, y: 40)
        
        //        loadView.addSubview(label)
        loadView.center = self.center
        do {
            let gif =  try UIImage(gifName: "moe_loader.gif") // add the string to enum
            let imageView = UIImageView(gifImage: gif, loopCount: -1) 
            
            imageView.frame = CGRect(x:0, y: 0, width: 100, height: 100)
            imageView.center = self.center
            self.addSubview(imageView)
        }catch{
            print("error")
        }
        let tapped = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tapped.numberOfTapsRequired = 2
        addGestureRecognizer(tapped)
        
        
    }
    
    @objc func doubleTapped() {
        
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
        
        activityIndicator.stopAnimating()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
}
