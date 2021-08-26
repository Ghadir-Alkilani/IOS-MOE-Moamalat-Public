//
//  var window: UIWindow?     var window: UIWindow? LoginVC.swift
//  Moamalat
//
//  Created by Ghadir kilani on 01/12/1442 AH.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - Outlets
    
 
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
            loginButton.setTitle("login_button_title".localized, for: .normal)
            
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
    
    @IBOutlet weak var loginWithTouchIdTitle: UILabel! {
        didSet {
            loginWithTouchIdTitle.text = "login_with_touchid_title" .localized
        }
        
    }
    var progressView = loadingView()
    
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        IdNumberTextField.text = "fntadmin"
        passwordTextField.text = "filenet"
        setupViewModel()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
//        let vc = InboxViewController.initializeFromStoryboard()
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalTransitionStyle = .crossDissolve
//        navigationController.modalPresentationStyle = .overFullScreen
        guard IdNumberTextField.text != "" &&  passwordTextField.text != "" else {return}
        
      viewModel.loginandEncrypt(IdNumberTextField.text?.replacingOccurrences(of: " ", with: ""), passwordTextField.text?.replacingOccurrences(of: " ", with: ""))
   // self.present(navigationController, animated: true, completion: nil)
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
