//
//  BaseViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 23/12/1442 AH.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))
     self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
