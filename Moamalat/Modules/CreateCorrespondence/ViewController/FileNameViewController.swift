//
//  FileNameViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 05/01/1443 AH.
//

import UIKit

protocol returnDocumentTitleDelegate:AnyObject{
    func DocumentTitle( text: String)
}

class FileNameViewController: UIViewController {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var defultNameBtn: UIButton!
    @IBOutlet weak var yesBtn: SecondaryButton!
    weak var delegate: returnDocumentTitleDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLable.font = UIFont.jFFlatRegular(fontSize: 15)
        nameTF.font = UIFont.jFFlatRegular(fontSize: 15)
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.jFFlatRegular(fontSize: 18)
        ]
        
        yesBtn.setAttributedTitle(NSAttributedString(string: "agree".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        defultNameBtn.setAttributedTitle(NSAttributedString(string: "default_name".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        

    }
    class func initializeFromStoryboard() -> FileNameViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.CreateCorrespondence, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: FileNameViewController.self)) as! FileNameViewController
    }
    
    @IBAction func defaultNameAction(_ sender: Any) {
            nameTF.text = "default_name".localized
    }
    
    @IBAction func yesBtn(_ sender: Any) {
        if nameTF.text == ""{
    // SnackBar.showMessage("ادخل اسم الملف")
        }else{
            delegate?.DocumentTitle(text: nameTF.text!)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
