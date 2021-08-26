//
//  FilterViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 01/01/1443 AH.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var corresDateLable: UILabel!
    
    @IBOutlet weak var fromLable: UILabel!
    @IBOutlet weak var forwardDateLable: UILabel!
    @IBOutlet weak var toLable: UILabel!
    @IBOutlet weak var showResultBtn: SecondaryButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var corresScopeTF: CustomDropDown!
    @IBOutlet weak var corresScoeLable: UILabel!
    @IBOutlet weak var toCorresDateTF: UITextField!
    @IBOutlet weak var fromForwardDateTF: UITextField!
    @IBOutlet weak var toForwardDateTF: UITextField!
    @IBOutlet weak var fromCorresDateTF: UITextField!
    @IBOutlet weak var corresTypeTF: CustomDropDown!
    @IBOutlet weak var corresDateView: UIView!
    @IBOutlet weak var corresDateStackView: UIStackView!
    @IBOutlet weak var forwardDateStackView: UIStackView!
    @IBOutlet weak var forwardDateView: UIView!
    @IBOutlet weak var corresTypeLable: UILabel!
    @IBOutlet weak var corresDateSegmentControll: CustomSegmentedControl!{
        didSet{
            corresDateSegmentControll.setButtonTitles(buttonTitles: ["all".localized,"month".localized,"week".localized,"day".localized,"other".localized])
        }
    }
    
    @IBOutlet weak var forwardDateSegmentControll: CustomSegmentedControl!{
        didSet{
            forwardDateSegmentControll.setButtonTitles(buttonTitles: ["all".localized,"month".localized,"week".localized,"day".localized,"other".localized])
        }
    }
    
    var searchText = String()
    var hijricYear = Int()
    let viewModel = FilterViewModel()
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setFonts()
        setupViewModel()
        CreateDatePicker()
        viewModel.getType()
        viewModel.getScope()
    }
    
    func  CreateDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        corresDateStackView.removeArrangedSubview(corresDateView)
        corresDateView.isHidden = true
        
        forwardDateStackView.removeArrangedSubview(forwardDateView)
        forwardDateView.isHidden = true
        
        corresDateSegmentControll.addTarget(self, action: #selector(handeleSegmentChange), for: .valueChanged)
        forwardDateSegmentControll.addTarget(self, action: #selector(handeleForwardSegmentChange), for: .valueChanged)
        
        fromCorresDateTF.inputView = datePicker
        fromCorresDateTF.inputAccessoryView = toolbar
        fromForwardDateTF.inputView = datePicker
        fromForwardDateTF.inputAccessoryView = toolbar
        toCorresDateTF.inputAccessoryView = toolbar
        toCorresDateTF.inputView = datePicker
        toForwardDateTF.inputAccessoryView = toolbar
        toForwardDateTF.inputView = datePicker
    }
    @objc fileprivate func handeleSegmentChange(){
        switch corresDateSegmentControll.selectedIndex {
        case 0:
             corresDateStackView.removeArrangedSubview(corresDateView)
            corresDateView.isHidden = true
            
            case 1:
                corresDateStackView.removeArrangedSubview(corresDateView)
                corresDateView.isHidden = true
        case 2:
            corresDateStackView.removeArrangedSubview(corresDateView)
            corresDateView.isHidden = true
        case 3:
            corresDateStackView.removeArrangedSubview(corresDateView)
            corresDateView.isHidden = true
        case 4:
            corresDateStackView.addArrangedSubview(corresDateView)
            corresDateView.isHidden = false
        default:
            print("d")
        }
      
    }
    @objc fileprivate func handeleForwardSegmentChange(){
        switch forwardDateSegmentControll.selectedIndex {
        case 0:
             forwardDateStackView.removeArrangedSubview(forwardDateView)
            forwardDateView.isHidden = true
            
            case 1:
                forwardDateStackView.removeArrangedSubview(forwardDateView)
                forwardDateView.isHidden = true
        case 2:
            forwardDateStackView.removeArrangedSubview(forwardDateView)
            forwardDateView.isHidden = true
        case 3:
            forwardDateStackView.removeArrangedSubview(forwardDateView)
            forwardDateView.isHidden = true
        case 4:
            forwardDateStackView.addArrangedSubview(forwardDateView)
            forwardDateView.isHidden = false
        default:
            print("d")
        }
      
    }
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_SA")
        dateFormatter.dateFormat = "yyyy/MM/dd"

//        if fromCorresDateTF.isFirstResponder {
//               dateFormatter.dateStyle = .medium
//               dateFormatter.timeStyle = .none
//            fromCorresDateTF.text = dateFormatter.string(from: datePicker.date)
//           }
        
//        if toCorresDateTF.isFirstResponder {
//               dateFormatter.dateStyle = .medium
//               dateFormatter.timeStyle = .none
//            toCorresDateTF.text = dateFormatter.string(from: datePicker.date)
//           }
//        if fromForwardDateTF.isFirstResponder {
//               dateFormatter.dateStyle = .medium
//               dateFormatter.timeStyle = .none
//            fromForwardDateTF.text = dateFormatter.string(from: datePicker.date)
//           }
//
//        if toForwardDateTF.isFirstResponder {
//               dateFormatter.dateStyle = .medium
//               dateFormatter.timeStyle = .none
//            toForwardDateTF.text = dateFormatter.string(from: datePicker.date)
//           }
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == fromCorresDateTF {
//            datePicker.datePickerMode = .date
//        }
//        if textField == fromForwardDateTF {
//            datePicker.datePickerMode = .date
//        }
//        if textField == toForwardDateTF {
//            datePicker.datePickerMode = .date
//        }
//        if textField == toCorresDateTF {
//            datePicker.datePickerMode = .date
//        }
//    }
    
    func setFonts(){
        datePicker.calendar = Calendar(identifier: .islamic)
        datePicker.minimumDate = Date()
        datePicker.sizeToFit()
      //  configureTapGesture()

        corresDateLable.font = UIFont.jFFlatRegular(fontSize: 18)
        corresScoeLable.font = UIFont.jFFlatRegular(fontSize: 15)
        corresTypeLable.font = UIFont.jFFlatRegular(fontSize: 15)
        forwardDateLable.font = UIFont.jFFlatRegular(fontSize: 18)
        corresTypeTF.font = UIFont.jFFlatRegular(fontSize: 15)
        corresScopeTF.font = UIFont.jFFlatRegular(fontSize: 15)
        toCorresDateTF.font = UIFont.jFFlatRegular(fontSize: 15)
        fromForwardDateTF.font = UIFont.jFFlatRegular(fontSize: 15)
        fromLable.font = UIFont.jFFlatRegular(fontSize: 15)
        toLable.font = UIFont.jFFlatRegular(fontSize: 15)
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.jFFlatRegular(fontSize: 18)
        ]
        
        showResultBtn.setAttributedTitle(NSAttributedString(string: "show_Result".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        cancelBtn.setAttributedTitle(NSAttributedString(string: "cancel".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        
    }
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func showResultAction(_ sender: Any) {
        let fullSearchModel  =  FullSearchModel.init()
       // print(CachingManager.maxScope())
        switch corresDateSegmentControll.selectedIndex  {
        
//        String searchText
//                int findIn
//                int hijricYear (default - 1)
//        int correspondenceType (default - 1)
//        int correspondenceDateType (default - 1) 0 other 1 day 7 week 30 month
//        int forwardingDateType (default - 1) 0 other 1 day 7 week 30 month
//        String fromDate (default - 1) like (10 / 10 / 1441)
//        String toDate (default - 1) like (10 / 10 / 1441)
//        String forwardingFromDate (default - 1) like (10 / 10 / 1441)
//        String forwardingToDate (default - 1) like (10 / 10 / 1441)
        case 0:
            fullSearchModel.correspondenceDateType = -1

        case 1:
            print("1")
            fullSearchModel.correspondenceDateType = 30
            fullSearchModel.fromDate = "-1"
            fullSearchModel.toDate = "-1"
        case 2:
            print("2")
            fullSearchModel.correspondenceDateType = 7
            fullSearchModel.fromDate = "-1"
            fullSearchModel.toDate = "-1"
        case 3:
            print("3")
            fullSearchModel.correspondenceDateType = 1
            fullSearchModel.fromDate = "-1"
            fullSearchModel.toDate = "-1"
        case 4:
            print("4")
            fullSearchModel.correspondenceDateType = 0
            fullSearchModel.forwardingDateType = 0
            fullSearchModel.fromDate = fromCorresDateTF.text
            fullSearchModel.toDate = toCorresDateTF.text
         
        default:
            print("")
        }
        switch corresDateSegmentControll.selectedIndex  {
        

        case 0:
            fullSearchModel.forwardingDateType = -1

        case 1:
            print("1")
            fullSearchModel.forwardingDateType = 30
            fullSearchModel.forwardingFromDate = "-1"
            fullSearchModel.forwardingToDate = "-1"
        case 2:
            print("2")
            fullSearchModel.forwardingDateType = 7
            fullSearchModel.forwardingFromDate = "-1"
            fullSearchModel.forwardingToDate = "-1"
        case 3:
            print("3")
            fullSearchModel.forwardingDateType = 1
            fullSearchModel.forwardingFromDate = "-1"
            fullSearchModel.forwardingToDate = "-1"
        case 4:
            print("4")
            fullSearchModel.correspondenceDateType = 0
            fullSearchModel.forwardingDateType = 0
            fullSearchModel.forwardingFromDate = fromForwardDateTF.text
            fullSearchModel.forwardingToDate = toForwardDateTF.text
         
        default:
            print("")
        }

        fullSearchModel.findIn = corresScopeTF.optionArray[corresScopeTF.selectedIndex].id!
        fullSearchModel.correspondenceType = corresTypeTF.optionArray[corresTypeTF.selectedIndex].id!
        
        fullSearchModel.searchText =  searchText
        fullSearchModel.hijricYear = hijricYear
        viewModel.getFullSearchResult(search:fullSearchModel)
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    class func initializeFromStoryboard() -> FilterViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.FilterFullSearch, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: FilterViewController.self)) as! FilterViewController
    }
    
    //MARK: - SetUp ViewModel
    
    func setupViewModel() {
    
        viewModel.presentViewController = { [unowned self] (vc) in
            self.present(vc, animated: true, completion: nil)
     
        }
      
        viewModel.typeArray = { [unowned self] (optionArray) in
            let obj = DropDownModel.init()
            obj.valueAr =  "all".localized
            obj.id = -1
            self.corresTypeTF.optionArray.append(obj)
            self.corresTypeTF.optionArray.append(contentsOf: optionArray)
            
            self.corresTypeTF.text = corresTypeTF.optionArray[0].valueAr
            self.corresTypeTF.selectedItem? = optionArray[0]
        }
        viewModel.scopeArray = { [unowned self] (optionArray) in
            let scope =  Int(CachingManager.maxScope() ?? "0")

            self.corresScopeTF.optionArray = optionArray
            self.corresScopeTF.text = corresScopeTF.optionArray[scope!].valueAr
            self.corresScopeTF.selectedItem? = optionArray[scope!]
        }
        
       
    }
    
//    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool
//    {
//        autocompleteTableView.isHidden = false
//        var substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//
//        searchAutocompleteEntriesWithSubstring(substring)
//        return true     // not sure about this - could be false
//    }
//
//    func searchAutocompleteEntriesWithSubstring(substring: String)
//    {
//        autocompleteUrls.removeAll(keepCapacity: false)
//        var indexOfPastUrls = 0
//
//        for curString in pastUrls
//        {
//            let substringRange = curString.rangeOfString(curString)
//
//            if (indexOfPastUrls  == 0)
//            {
//                autocompleteUrls.append(curString)
//            }
//            indexOfPastUrls = indexOfPastUrls + 1
//        }
//        autocompleteTableView.reloadData()
//    }
    
   
}


