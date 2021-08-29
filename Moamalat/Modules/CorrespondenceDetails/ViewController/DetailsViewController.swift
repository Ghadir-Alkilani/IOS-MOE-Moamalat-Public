//
//  DetailsViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/01/1443 AH.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var attachBtn: UIButton!
    @IBOutlet weak var instructionBtn: UIButton!
    @IBOutlet weak var forwardingBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Initialization
    
    
    class func initializeFromStoryboard() -> DetailsViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.Details, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as! DetailsViewController
    }

    @IBAction func headerBtnAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            detailsBtn.isSelected = true
            attachBtn.isSelected = false
            instructionBtn.isSelected = false
            forwardingBtn.isSelected = false
            chatBtn.isSelected = false

        case 1:
            detailsBtn.isSelected = false
            attachBtn.isSelected = true
            instructionBtn.isSelected = false
            forwardingBtn.isSelected = false
            chatBtn.isSelected = false
        case 2:
            detailsBtn.isSelected = false
            attachBtn.isSelected = false
            instructionBtn.isSelected = true
            forwardingBtn.isSelected = false
            chatBtn.isSelected = false
        case 3:
            detailsBtn.isSelected = false
            attachBtn.isSelected = false
            instructionBtn.isSelected = false
            forwardingBtn.isSelected = true
            chatBtn.isSelected = false
        case 4:
            detailsBtn.isSelected = false
            attachBtn.isSelected = false
            instructionBtn.isSelected = false
            forwardingBtn.isSelected = false
            chatBtn.isSelected = true
        default:
            print("other")
        }
    }
}
