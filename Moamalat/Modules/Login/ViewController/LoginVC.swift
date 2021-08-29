//
//  var window: UIWindow?     var window: UIWindow? LoginVC.swift
//  Moamalat
//
//  Created by Ghadir kilani on 01/12/1442 AH.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - Outlets
    
 
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerViewWidthConst: NSLayoutConstraint!
    @IBOutlet weak var IdNumberTextField: UITextField! {
        didSet {
            
           // IdNumberTextField.setLeftPaddingPoints(10)
            IdNumberTextField.attributedPlaceholder = NSAttributedString(string: "login_id_textfield_placeholder".localized, attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.jFFlatRegular(fontSize: 15)!
            ])
          //  IdNumberTextField.textAlignment = LanguageManager.manager.isRTLLanguage ? .right : .left
            
        }
    }
    
    @IBOutlet weak var loginButton: SecondaryButton! {
        didSet {
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont.jFFlatRegular(fontSize: 18)
            ]
            loginButton.setAttributedTitle(NSAttributedString(string: "login_button_title".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        }
        
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
           // passwordTextField.setLeftPaddingPoints(10)
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "login_password_textfield_placeholder".localized, attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.jFFlatRegular(fontSize: 15)!
            ])
          //  passwordTextField.textAlignment = LanguageManager.manager.isRTLLanguage ? .right : .left
        }
    }
    
    @IBOutlet weak var copyNumLable: UILabel! {
        didSet {
            copyNumLable.text = "copy_num".localized
            copyNumLable.font = UIFont.jFFlatRegular(fontSize: 13)
        }
        
    }
    
    @IBOutlet weak var loginWithTouchIdTitle: UILabel! {
        didSet {
            loginWithTouchIdTitle.text = "login_with_touchid_title" .localized
            loginWithTouchIdTitle.font = UIFont.jFFlatRegular(fontSize: 15)

        }
    }
    var progressView = loadingView()
    let viewModel = LoginViewModel()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IdNumberTextField.text = "fntadmin"
        passwordTextField.text = "filenet"
        //setUpPadScreen()
        setupViewModel()
       
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
            var newConstraint = NSLayoutConstraint()

        if UIDevice.current.orientation.isPortrait {
                // activate landscape changes
               
            backgroundImage.image = UIImage (named: "BG")
        } else if UIDevice.current.orientation.isLandscape {
                // activate portrait changes
            backgroundImage.image = UIImage (named: "MaskLoginLand")
            }

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    if UIDevice.current.userInterfaceIdiom  == .pad {
        containerViewWidthConst.constant = 600
    }
        if let orientation = self.view.window?.windowScene?.interfaceOrientation {
            let landscape = orientation == .landscapeLeft || orientation == .landscapeRight
            if landscape{
                
                backgroundImage.image = UIImage (named: "MaskLoginLand")
               
            }else{
                backgroundImage.image = UIImage (named: "BG")
            }
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        setUpPadScreen()
//    }
//    func setUpPadScreen()  {
//        if UIDevice.current.userInterfaceIdiom  == .pad {
//
//            if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isPortrait{
//                backgroundImage.image = UIImage (named: "MaskLoginLand")
//            }
//            if  UIDevice.current.orientation.isLandscape {
//
//  backgroundImage.image = UIImage (named: "MaskLoginLand")
//
//            }
//
//    }
//    }
    
    //MARK: - Actions
    
    @IBAction func loginBtn(_ sender: Any) {

        guard IdNumberTextField.text != "" &&  passwordTextField.text != "" else {return}
        
      viewModel.loginandEncrypt(IdNumberTextField.text?.replacingOccurrences(of: " ", with: ""), passwordTextField.text?.replacingOccurrences(of: " ", with: ""))

    }
    
    
        //MARK: - SetUp ViewModel
    
        func setupViewModel() {
    
            viewModel.presentViewController = { [unowned self] (vc) in
    
                self.present(vc, animated: true, completion: nil)
            }
            viewModel.startLoadingView = {
                self.progressView = loadingView.init(frame: self.view.frame)
                self.progressView.startAnimating()
                self.view.addSubview(self.progressView)
            }
            viewModel.stopLoadingView = {
              self.progressView.stopAnimating()
                self.progressView.removeFromSuperview()
            }
           
        }
    
    //MARK: - Initialization
    
    class func initializeFromStoryboard() -> LoginVC {
        
        let storyboard = UIStoryboard(name: Storyboards.Login, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as! LoginVC
    }

}
