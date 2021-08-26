//
//  SearchViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/12/1442 AH.
//

import UIKit
import BarcodeScanner

class SearchViewController: UIViewController {
    
    @IBOutlet weak var advanceSearchView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var searchBtn: PrimaryButton!
    @IBOutlet weak var searchLable: UILabel!
    @IBOutlet weak var toLable: UILabel!
    @IBOutlet weak var fromLable: UILabel!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet weak var searchTextTF: UITextField!
    @IBOutlet weak var searchByDateBtn: UIButton!
    @IBOutlet weak var toDateTF: UITextField!
    @IBOutlet weak var fromDateTF: UITextField!
    @IBOutlet weak var searchByForwardBtn: UIButton!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var scopeView: UIView!
    @IBOutlet weak var filterLable: UILabel!
    @IBOutlet weak var filterYearTF: DropDown!
    @IBOutlet weak var searchResultLable: UILabel!
    @IBOutlet weak var corresStatusLable: UILabel!
    @IBOutlet weak var corresScopeLable: UILabel!
    @IBOutlet weak var searchByForawadDateLable: UILabel!
    @IBOutlet weak var searchByDateLable: UILabel!
    @IBOutlet weak var barcodeBtn: UIButton!
    @IBOutlet weak var corresTypeLable: UILabel!
    @IBOutlet weak var fullSearchView: UIView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var corresTypeTF: CustomDropDown!
    @IBOutlet weak var corresYearTF: DropDown!
    @IBOutlet weak var corresNumTF: UITextField!
    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var scopeTF: CustomDropDown!
    @IBOutlet weak var statusTF: CustomDropDown!
    
    @IBOutlet weak var segmentControll:
        CustomSegmentedControl! {
        
        didSet{
            segmentControll.setButtonTitles(buttonTitles: ["AdvancedSearch".localized,"FullSearch".localized])
        }
    }
  //  @IBOutlet weak var autocompleteTableView: UITableView!
    let autocompleteTableView = UITableView(frame: CGRect(x:0,y:250,width: 100,height: 100), style: UITableView.Style.plain)
    var isFilterWithAAT = Bool()
    var isFilterWithHash = Bool()
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let dateFormatter = DateFormatter()
    var dateArray = [String]()
    var today = Date()
    let viewModel = SearchViewModel()
    let controller = BarcodeScannerViewController()
    var progressView = loadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton( self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), imageName:  "list")
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(addTapped))
        containerStackView.removeArrangedSubview(fullSearchView)
        fullSearchView.isHidden = true
        segmentControll.addTarget(self, action: #selector(handeleSegmentChange), for: .valueChanged)
   self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,for: .default)
    searchTextTF.delegate = self
        controller.codeDelegate = self
        controller.title = "scan"
    autocompleteTableView.delegate = self
          autocompleteTableView.dataSource = self
       autocompleteTableView.isScrollEnabled = true
      autocompleteTableView.isHidden = false
        controller.errorDelegate = self
        controller.dismissalDelegate = self
        viewModel.getType()
        viewModel.getScope()
        viewModel.getStatus()
        setupViewModel()
        getHijiriYears()
        setFonts()
        viewModel.getMaxSearchScope()
//        if searchTextTF.sta {
//            let obj = AutoCompleteModel.init()
//                           obj.findIn = 1
//                           obj.searchText = searchTextTF.text
//                           obj.searchIn = "1"
//                          // autocompleteTableView.isHidden = false
//                           viewModel.getAutocomplete(model: obj)
//                          // autocompleteTableView.reloadData()        }
//      searchTextTF.filterStrings(["Red", "Blue", "Yellow"])
//
//    }
    }
    @objc func addTapped (){
       self.navigationController?.popViewController(animated:true)
    }
    func setFonts(){
        corresTypeLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        corresScopeLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        corresNumTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        corresStatusLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        searchByDateLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        searchByForawadDateLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        statusTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        scopeTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        subjectTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        corresTypeTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        corresYearTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        filterYearTF.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        filterLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        searchResultLable.font = UIFont(name: Fonts.JFFlatRegular, size: 20)
        toLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        fromLable.font = UIFont(name: Fonts.JFFlatRegular, size: 14)
        searchLable.font = UIFont(name: Fonts.JFFlatRegular, size: 20)
        dateStackView.removeArrangedSubview(dateView)
        
        dateView.isHidden = true
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.jFFlatRegular(fontSize: 15)
        ]
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 30
        barcodeBtn.setAttributedTitle(NSAttributedString(string: "barcode".localized, attributes: attributes as [NSAttributedString.Key : Any]), for: .normal)
        let attr = [
            NSAttributedString.Key.foregroundColor: UIColor.MoamalatDarkGray,
            NSAttributedString.Key.font : UIFont(name: Fonts.JFFlatRegular, size: 15)
        ]
        
        corresNumTF.attributedPlaceholder = NSAttributedString(string: "correspondence_number".localized, attributes: attr as [NSAttributedString.Key : Any])
        
        subjectTF.attributedPlaceholder = NSAttributedString(string: "correspondence_subject".localized, attributes:attr as [NSAttributedString.Key : Any])
      //  configureTapGesture()

        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.maximumDate = Date()
        datePicker.sizeToFit()
        dateFormatter.locale = Locale(identifier: "en_SA")
        dateFormatter.dateFormat = "yyyy/MM/dd"
            toDateTF.text = dateFormatter.string(from: datePicker.date)
        fromDateTF.text = dateFormatter.string(from: datePicker.date)
        CreateDatePicker()
        
       // searchTextTF.
    }
    
    func  CreateDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        fromDateTF.inputView = datePicker
        fromDateTF.inputAccessoryView = toolbar
        toDateTF.inputAccessoryView = toolbar
        toDateTF.inputView = datePicker
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//            if textField == fromDateTF {
//                datePicker.datePickerMode = .date
//            }
//            if textField == toDateTF {
//                datePicker.datePickerMode = .date
//            }
//
//        }
//
    @objc func donePressed(){
       
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_SA")
        dateFormatter.dateFormat = "yyyy/MM/dd"

        if fromDateTF.isFirstResponder {
//               dateFormatter.dateStyle = .medium
//               dateFormatter.timeStyle = .none
            fromDateTF.text = dateFormatter.string(from: datePicker.date)
            view.endEditing(true)
           }
        if toDateTF.isFirstResponder {
             
            toDateTF.text = dateFormatter.string(from: datePicker.date)
            view.endEditing(true)

           }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == fromDateTF {
                datePicker.datePickerMode = .date
            }
            if textField == toDateTF {
                datePicker.datePickerMode = .date
            }
            
        }
    @objc fileprivate func handeleSegmentChange(){
        switch segmentControll.selectedIndex {
        case 0:
            containerStackView.removeArrangedSubview(fullSearchView)
            fullSearchView.isHidden = true
            containerStackView.addArrangedSubview(advanceSearchView)
            advanceSearchView.isHidden = false
            case 1:
                containerStackView.removeArrangedSubview(advanceSearchView)
                advanceSearchView.isHidden = true
                containerStackView.addArrangedSubview(fullSearchView)
                fullSearchView.isHidden = false
        default:
            print("d")
        }
      
    }
    
    @IBAction func searchByDateAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            searchByForwardBtn.isSelected = false
            containerStackView.layoutIfNeeded()
            dateStackView.removeArrangedSubview(dateView)
            dateView.isHidden = true
        } else{
            sender.isSelected = true
            searchByForwardBtn.isSelected = false
            containerStackView.layoutIfNeeded()
            dateStackView.addArrangedSubview(dateView)
            dateView.isHidden = false
        }
        
    }
    
    @IBAction func searchByForwardDateAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            searchByDateBtn.isSelected = false
            containerStackView.layoutIfNeeded()
            dateStackView.removeArrangedSubview(dateView)
            dateView.isHidden = true
        } else{
            sender.isSelected = true
            searchByDateBtn.isSelected = false
            containerStackView.layoutIfNeeded()
            dateStackView.addArrangedSubview(dateView)
            dateView.isHidden = false
        }
    }
   
    //MARK: - SetUp ViewModel
    
    func setupViewModel() {
        
        
        viewModel.startLoadingView = {
            self.progressView = loadingView.init(frame: self.view.frame)
            self.progressView.startAnimating()
            self.view.addSubview(self.progressView)
        }
        viewModel.stopLoadingView = {
          self.progressView.stopAnimating()
            self.progressView.removeFromSuperview()
        }
        viewModel.presentViewController = { [unowned self] (vc) in
            self.present(vc, animated: true, completion: nil)
           // self.navigationController?.pushViewController(vc, animated: true)
        }
        
        viewModel.dismissVC = { [unowned self] () in
            self.controller.dismiss(animated: true) {
                controller.reset()
            }
        }
        
        viewModel.typeArray = { [unowned self] (optionArray) in
            self.corresTypeTF.optionArray = optionArray
            self.corresTypeTF.text = corresTypeTF.optionArray[0].valueAr
            self.corresTypeTF.selectedItem? = optionArray[0]
        }
        viewModel.scopeArray = { [unowned self] (optionArray) in
            self.scopeTF.optionArray = optionArray
            self.scopeTF.text = scopeTF.optionArray[0].valueAr
            self.scopeTF.selectedItem? = optionArray[0]
        }
        
        viewModel.statusArray = { [unowned self] (optionArray) in
            self.statusTF.optionArray = optionArray
            self.statusTF.text = statusTF.optionArray[0].valueAr
            self.statusTF.selectedItem? = optionArray[0]
        }
        viewModel.reloadTableView = {
            self.autocompleteTableView.reloadData()
        }
        viewModel.autoCompleteArray = {  [unowned self] (optionArray) in
//            var array = [String]()
//           // var destinationID = [Int]()
//            for index in 0...optionArray.count-1 {
//                let aObject = optionArray[index]
//                array.append(aObject.valueAr ?? "")
//              // destinationID.append(aObject.destinationId!)
//            }
//            searchTextTF.filterStrings(["Red", "Blue", "Yellow"])
        }
    }

    @IBAction func searchAction(_ sender: Any) {
        let searchModel = SearchModel.init()
        searchModel.searchScope = scopeTF.optionArray[scopeTF.selectedIndex].id ?? 0
       // searchModel.searchScope = 2
        searchModel.correspondenceStatus = statusTF.optionArray[statusTF.selectedIndex].id!
//2
        searchModel.correspondenceId =  corresNumTF.text
        searchModel.startRow = 1
        searchModel.endRow = 20
        searchModel.fromDate =  "1442/05/01" // fromDateTF.text
        searchModel.toDate =  "1442/05/22"   // toDateTF.text
        searchModel.hijricYear = Int(corresYearTF.text ?? "")
        searchModel.subject = subjectTF.text
        searchModel.incomingExternalNo = ""
        if searchByDateBtn.isSelected{
            searchModel.deliverDate = false
        }else if searchByForwardBtn.isSelected {
            searchModel.deliverDate = true
        }
        
        searchModel.correspondenceTypeId = (corresTypeTF.optionArray[corresTypeTF.selectedIndex].id!).description
           // "3"
            
        viewModel.getSearchResult(search: searchModel)
        
    }
    
    @IBAction func filterBtnaction(_ sender: Any) {
        let vc = FilterViewController.initializeFromStoryboard()
        vc.searchText = searchTextTF.text ?? ""
        let hijricYear = filterYearTF.text
        
        if hijricYear == "all".localized{
            vc.hijricYear = -1
        }else{
            vc.hijricYear = Int(hijricYear ?? "-1")!

        }
        present(vc, animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    class func initializeFromStoryboard() -> SearchViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.Search, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as! SearchViewController
    }
}

extension SearchViewController:BarcodeScannerCodeDelegate{
   func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
       print("code=\(code)")
       print("type=\(type)")
    viewModel.getCorrespondanceInfoFromBarcode(code: code)
          }
    
    func openBarcodeView() {
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func addBarcode(_ sender: Any) {
        openBarcodeView()
      //  presenter.getCorrespondanceInfoFromBarcode(barcode: "14413131")
    }
    
}
extension SearchViewController:BarcodeScannerErrorDelegate{
   func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
      print(error)
   }
    
    func getHijiriYears(){
       // dateArray.append( "search_all".localized)
    for _ in 1...10 {
      let tomorrow = Calendar.current.date(byAdding: .day, value: -355, to: today)
      let date = DateFormatter()
      date.dateFormat = "yyyy"
        date.locale = Locale(identifier: "en_SA")
        let stringDate : String = date.string(from: today)
      today = tomorrow!
      dateArray.append(stringDate)
    
    }
        self.corresYearTF.optionArray = dateArray
        corresYearTF.text = corresYearTF.optionArray[0]
        self.filterYearTF.optionArray.append("all".localized)
        self.filterYearTF.optionArray.append(contentsOf: dateArray)
        filterYearTF.text = filterYearTF.optionArray[0]
        
    }
}

extension SearchViewController:BarcodeScannerDismissalDelegate{
   func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
       controller.dismiss(animated: true, completion: nil)
       controller.reset()
   }
   
   
}

// MARK:- UITextField Delegate

extension SearchViewController : UITextFieldDelegate {


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if searchTextTF.isFirstResponder{
            if searchTextTF.text?.count == 4 {

                let obj = AutoCompleteModel.init()
                obj.findIn = 1
                obj.searchText = searchTextTF.text
                obj.searchIn = "1"
                autocompleteTableView.isHidden = false
              //  autocompleteTableView.reloadData()
                viewModel.getAutocomplete(model: obj)
            }

        }
        return true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
//        return  true // !autoCompleteText( in : textField, using: string, suggestionsArray: viewModel.autoCompleteResultModel)
//    }
////            if string == "@" {
////                isFilterWithAAT = true
////                return true
////            }
////            if string == "#" {
////                isFilterWithHash = true
////                return true
////            }
////            if !((textField.text?.contains("@"))!) {
////                isFilterWithAAT = false
////                return false
////            }
////            if ((textField.text?.contains("#"))!){
////                isFilterWithHash = false
////                return false
////            }
////        }
////
////        if (text.length < 2) {
////           // newString = [text substringFromIndex:1];
////        }else{
////           // NSArray *Array = [text componentsSeparatedByString:@"@"];
////          //  newString = [Array objectAtIndex:1];
////        }
////        [self getAutoComplete:@"2" searchTxt:newString];
////        return YES;
////    }
////    if (isFilterWithHash) {
////        [self fillAutoCompleteLocal];
////        [self viewAutoComplete];
////        return YES;
////    }
////
////    if ([textField.text length] > 2 && !isFilterWithHash && !isFilterWithAAT) {
////        NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
////        NSString* text =[[textField text] stringByAppendingString:string];
////        [self getAutoComplete:[preferences objectForKey:@"maxScope"] searchTxt:text];
////    }
////return YES;
//
//
////        if textField.text?.count == 4 {
////
////        }
//
//
//
////    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
////    return true
////}
////
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        textField.resignFirstResponder()
////        return true
////    }
//////func textFieldDidBeginEditing(_ textField: UITextField) {
////////    if corresNumTF.isFirstResponder {
////////        corresNumTF.placeholder = ""
////////    }else if subjectTF.isFirstResponder{
////////        subjectTF.placeholder = ""
////////    }
////////    if textField == fromDateTF {
////////        datePicker.datePickerMode = .date
////////    }
////////    if textField == toDateTF {
////////        datePicker.datePickerMode = .date
////////    }
//////}
////
//////func textFieldDidEndEditing(_ textField: UITextField) {
//////    if corresNumTF.placeholder == ""{
//////        corresNumTF.placeholder = "correspondence_number".localized
//////    }else if subjectTF.placeholder == ""{
//////        subjectTF.placeholder = "correspondence_subject".localized
//////    }
//////}
//    func autoCompleteText( in textField: UITextField, using string: String, suggestionsArray: [String]) -> Bool {
//            if !string.isEmpty,
//                let selectedTextRange = textField.selectedTextRange,
//                selectedTextRange.end == textField.endOfDocument,
//                let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
//                let text = textField.text( in : prefixRange) {
//                let prefix = text + string
//                let matches = suggestionsArray.filter {
//                    $0.hasPrefix(prefix)
//                }
//                if (matches.count > 0) {
//                    textField.text = matches[0]
//                    if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
//                        textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
//                        return true
//                    }
//                }
//            }
//            return false
//        }
//    }
//
//
// MARK:- UITableViewController DataSource

extension SearchViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.autoCompleteResultModel.count)
        return  viewModel.autoCompleteResultModel.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let autoCompleteRowIdentifier = "AutoCompleteRowIdentifier"
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: autoCompleteRowIdentifier, for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        let obj = viewModel.autoCompleteResultModel[index]

        cell.textLabel?.text = obj.valueAr
        print(obj.valueAr)
        return cell
    }

  
}



//MARK:- UITableViewController Delegate

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        searchTextTF.text = selectedCell.textLabel?.text
        autocompleteTableView.isHidden = true

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextTF.resignFirstResponder()
            return true
    }


}

//    "correspondenceId":"",
//        "correspondenceStatus":2,
//        "correspondenceTypeId":"3",
//        "deliverDate":true,
//        "endRow":20,
//        "fromDate":"1442/05/01",
//        "hijricYear":1442,
//        "incomingExternalNo":"",
//        "searchScope":2,
//        "startRow":1,
//        "subject":"",
//        "toDate":"1442/05/22"
//    }
