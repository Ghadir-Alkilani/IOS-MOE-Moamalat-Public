//
//  BaseViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 23/12/1442 AH.
//

import UIKit

class BaseViewController: UIViewController {

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))
     self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)

    }
    

}
