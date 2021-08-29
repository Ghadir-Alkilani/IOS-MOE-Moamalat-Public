//
//  SettingsViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 18/01/1443 AH.
//

import UIKit

class SettingsViewController: UIViewController {

    
    //MARK: - Outlets
    
    @IBOutlet weak var enableLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var enableOfflineSwitch: UISwitch!
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyLayout()
    }
    
    func applyLayout() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton( self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), imageName:  "list")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,for: .default)
             let toolbar = UIToolbar()
             toolbar.sizeToFit()
        titleLable.font = UIFont.jFFlatRegular(fontSize: 18)
        enableLable.font = UIFont.jFFlatRegular(fontSize: 18)
    }
    
    //MARK: - Initialization
    
    
    class func initializeFromStoryboard() -> SettingsViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.Settings, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as! SettingsViewController
    }

  

}
