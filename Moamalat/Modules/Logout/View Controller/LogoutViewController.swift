//
//  LogoutViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 25/12/1442 AH.
//

import UIKit

class LogoutViewController: UIViewController {
    @IBOutlet weak var logoutTitle: UILabel!
    @IBOutlet weak var logoutMessage: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutTitle.text = "Confirmation".localized
        logoutTitle.font = UIFont.jFFlatRegular(fontSize: 13)
      //  logoutTitle.textColor = UIColor(hexString: "5E00DD")
        logoutMessage.text = "logOutAlert".localized
        logoutMessage.font = UIFont.jFFlatRegular(fontSize: 13)
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.jFFlatRegular(fontSize: 13)
        ]
        yesBtn.setAttributedTitle(NSAttributedString(string: "Yes".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
//        cancelBtn.layer.borderWidth = 2
//        cancelBtn.layer.borderColor = UIColor(hexString: "5E00DD").cgColor
        let attributes2 = [
            NSAttributedString.Key.font : UIFont.jFFlatRegular(fontSize: 13)!
        ] as [NSAttributedString.Key : Any]
        cancelBtn.setAttributedTitle(NSAttributedString(string: "cancel".localized, attributes: attributes2 as [NSAttributedString.Key : Any]), for: .normal)
        // Do any additional setup after loading the view.
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func yesAction(_ sender: Any) {
        let vc = LoginVC.initializeFromStoryboard()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    class func initializeFromStoryboard() -> LogoutViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.Logout, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: LogoutViewController.self)) as! LogoutViewController
    }

    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
