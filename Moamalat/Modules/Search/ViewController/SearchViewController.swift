//
//  SearchViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 20/12/1442 AH.
//

import UIKit
import BarcodeScanner

class SearchViewController: UIViewController {
    
    //MARK: - Outlets
    
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
            segmentControll.setButtonTitles(buttonTitles: ["AdvancedSearch".localized])
        }
    }
    
    //MARK: - Variables
    
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
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
          viewModel.getType()
        viewModel.getScope()
        viewModel.getStatus()
        setupViewModel()
        getHijiriYears()
        setFonts()
        viewModel.getMaxSearchScope()
        adjustLayout()
    }
    
    func adjustLayout()  {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton( self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), imageName:  "list")
        containerStackView.removeArrangedSubview(fullSearchView)
        fullSearchView.isHidden = true
        segmentControll.addTarget(self, action: #selector(handeleSegmentChange), for: .valueChanged)
   self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,for: .default)
    searchTextTF.delegate = self
        controller.codeDelegate = self
        controller.title = "scan"
//          autocompleteTableView.delegate = self
//          autocompleteTableView.dataSource = self
//       autocompleteTableView.isScrollEnabled = true
//      autocompleteTableView.isHidden = false
        controller.errorDelegate = self
        controller.dismissalDelegate = self
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
        
    }
    
    func  CreateDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        fromDateTF.inputView = datePicker
        fromDateTF.inputAccessoryView = toolbar
        toDateTF.inputAccessoryView = toolbar
        toDateTF.inputView = datePicker
    }

    @objc func donePressed(){
       
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_SA")
        dateFormatter.dateFormat = "yyyy/MM/dd"

        if fromDateTF.isFirstResponder {

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
//            case 1:
//                containerStackView.removeArrangedSubview(advanceSearchView)
//                advanceSearchView.isHidden = true
//                containerStackView.addArrangedSubview(fullSearchView)
//                fullSearchView.isHidden = false
        default:
            print("d")
        }
      
    }
    
    //MARK: - Actions
    
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
    }

    @IBAction func searchAction(_ sender: Any) {
        let searchModel = SearchModel.init()
        searchModel.searchScope = scopeTF.optionArray[scopeTF.selectedIndex].id ?? 0
        searchModel.correspondenceStatus = statusTF.optionArray[statusTF.selectedIndex].id!
        searchModel.correspondenceId =  corresNumTF.text
        searchModel.startRow = 1
        searchModel.endRow = 20
        searchModel.fromDate =  fromDateTF.text
        searchModel.toDate = toDateTF.text
        searchModel.hijricYear = Int(corresYearTF.text ?? "")
        searchModel.subject = subjectTF.text
        searchModel.incomingExternalNo = ""
        if searchByDateBtn.isSelected{
            searchModel.deliverDate = false
        }else if searchByForwardBtn.isSelected {
            searchModel.deliverDate = true
        }
        
        searchModel.correspondenceTypeId = (corresTypeTF.optionArray[corresTypeTF.selectedIndex].id!).description
            
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

}
