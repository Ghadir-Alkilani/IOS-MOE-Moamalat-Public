//
//  CreateCorrespondenceViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/01/1443 AH.
//

import UIKit

class CreateCorrespondenceViewController: UIViewController {
    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var categoryTF: CustomDropDown!
    @IBOutlet weak var remarksTV: UITextView!
    @IBOutlet weak var confidentialtyTF: CustomDropDown!
    @IBOutlet weak var correspondenceDateTF: UITextField!
    @IBOutlet weak var confidentialtyLable: UILabel!
    @IBOutlet weak var corresTypeTF: CustomDropDown!
    
    let viewModel = CreateCorrespondenceViewModel()
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.sizeToFit()
        datePicker.minimumDate = Date()
     //   CreateDatePicker()
        dateFormatter.locale = Locale(identifier: "en_SA")
        dateFormatter.dateFormat = "yyyy/MM/dd"
            correspondenceDateTF.text = dateFormatter.string(from: datePicker.date)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,for: .default)
        navigationController?.navigationBar.prefersLargeTitles = false

        subjectTF.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        typeLable.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        corresTypeTF.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        categoryLable.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        correspondenceDateTF.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        categoryTF.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        confidentialtyTF.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        confidentialtyLable.font = UIFont(name: Fonts.JFFlatRegular, size: 15)

        remarksTV.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        remarksTV.text = "remarks".localized
        remarksTV.textColor = .lightGray
        let attr = [
            NSAttributedString.Key.foregroundColor: UIColor.MoamalatDarkGray,
            NSAttributedString.Key.font : UIFont(name: Fonts.JFFlatRegular, size: 15)
        ]
        
        subjectTF.attributedPlaceholder = NSAttributedString(string: "correspondence_subject".localized, attributes:attr as [NSAttributedString.Key : Any])
     //  configureTapGesture()
        viewModel.getType()
        viewModel.getCategory()
        viewModel.getConfidentialty()
        setupViewModel()
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(addTapped), imageName: "back")
                   
    }
//    func  CreateDatePicker(){
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
//        toolbar.setItems([doneBtn], animated: true)
//        correspondenceDateTF.inputView = datePicker
//        correspondenceDateTF.inputAccessoryView = toolbar
//
//    }
//    @objc func donePressed(){
//
//        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.timeStyle = DateFormatter.Style.short
//        dateFormatter.locale = Locale(identifier: "en_SA")
//        dateFormatter.dateFormat = "yyyy/MM/dd"
//
//        if correspondenceDateTF.isFirstResponder {
//               dateFormatter.dateStyle = .medium
//               dateFormatter.timeStyle = .none
//            correspondenceDateTF.text = dateFormatter.string(from: datePicker.date)
//           }
   // }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc func addTapped (){
       self.navigationController?.popViewController(animated:true)
    }
    //MARK: - SetUp ViewModel
    
    func setupViewModel() {
    
        viewModel.presentViewController = { [unowned self] (vc) in
            self.navigationController?.pushViewController(vc, animated: true)

           // self.navigationController?.pushViewController(vc, animated: true)
        }
        
        viewModel.typeArray = { [unowned self] (optionArray) in
            self.corresTypeTF.optionArray = optionArray
            self.corresTypeTF.text = corresTypeTF.optionArray[0].valueAr
            self.corresTypeTF.selectedItem? = optionArray[0]
        }
        viewModel.categoryArray = { [unowned self] (optionArray) in
            self.categoryTF.optionArray = optionArray
            self.categoryTF.text = categoryTF.optionArray[0].valueAr
            self.categoryTF.selectedItem? = optionArray[0]
        }
        
        viewModel.confidentialtyArray = { [unowned self] (optionArray) in
            self.confidentialtyTF.optionArray = optionArray
            self.confidentialtyTF.text = confidentialtyTF.optionArray[0].valueAr
            self.confidentialtyTF.selectedItem? = optionArray[0]
        }
    }
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    class func initializeFromStoryboard() -> CreateCorrespondenceViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.CreateCorrespondence, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: CreateCorrespondenceViewController.self)) as! CreateCorrespondenceViewController
    }
    @IBAction func nextAction(_ sender: Any) {
       let vc  = AttachmentViewController.initializeFromStoryboard()
        self.navigationController?.pushViewController(vc, animated: true)

        let model = CreateCorrespondenceModel()
        model.categoryId = categoryTF.optionArray[categoryTF.selectedIndex].id!
        model.typeId = corresTypeTF.optionArray[corresTypeTF.selectedIndex].id!
        model.confidentialityId = confidentialtyTF.optionArray[confidentialtyTF.selectedIndex].id!
        model.subject = subjectTF.text
        model.remarks = remarksTV.text
        model.correspondenceDate = correspondenceDateTF.text
        model.attachments = ""
        model.actionPageSource = -1
       viewModel.createCorrespondance(createModel: model)
        
    }
    
  

}
extension CreateCorrespondenceViewController : UITextViewDelegate{

    func textViewDidBeginEditing(_ textView: UITextView) {

        if remarksTV.textColor == UIColor.lightGray {
            remarksTV.text = ""
            remarksTV.textColor = UIColor.MoamalatDarkGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if remarksTV.text == "" {

            remarksTV.text = "remarks".localized
            remarksTV.textColor = UIColor.lightGray
        }
    }
}

// MARK:- UITextField Delegate

extension CreateCorrespondenceViewController : UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
    return true
}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
func textFieldDidBeginEditing(_ textField: UITextField) {
    if subjectTF.isFirstResponder{
           subjectTF.placeholder = ""
       }
}

func textFieldDidEndEditing(_ textField: UITextField) {
    if subjectTF.placeholder == ""{
        subjectTF.placeholder = "correspondence_subject".localized
    }
}
}
