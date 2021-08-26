//
//  SentCorrespondenceViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 16/01/1443 AH.
//

import UIKit

class SentCorrespondenceViewController: UIViewController {
    
    @IBOutlet weak var toCorresDateTF: UITextField!
    @IBOutlet weak var fromCorresDateTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var corresDateStackView: UIStackView!
    @IBOutlet weak var corresDateView: UIView!
    
    @IBOutlet weak var showResultLable: UILabel!
    @IBOutlet weak var showResultBtn: PrimaryButton!
    @IBOutlet weak var corresDateSegmentControll: CustomSegmentedControl!{
        didSet{
            corresDateSegmentControll.setButtonTitles(buttonTitles: ["today".localized,"last_Week".localized,"last_Month".localized,"other".localized])
        }
    }
    var progressView = loadingView()
    let viewModel = SentViewModel()
    let dateFormatter = DateFormatter()
    var sentArray = [SentResultModel]()
    var weekArray = [SentResultModel]()
    var monthArray = [SentResultModel]()
    var otherArray = [SentResultModel]()
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustLayout()

    }
    
    func  adjustLayout(){
        setupViewModel()
        tableView.isHidden = false

        toCorresDateTF.font = UIFont.jFFlatRegular(fontSize: 15)
        showResultLable.font = UIFont.jFFlatRegular(fontSize: 15)
        toCorresDateTF.font = UIFont.jFFlatRegular(fontSize: 15)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton( self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), imageName:  "list")

   self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,for: .default)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
      //  self.tableView.register(UINib(nibName: "PrivateTableViewCell", bundle: nil), forCellReuseIdentifier: "PrivateCell")
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
   corresDateSegmentControll.addTarget(self, action: #selector(handeleSegmentChange), for: .valueChanged)
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        datePicker.maximumDate = Date()
        datePicker.sizeToFit()
        dateFormatter.locale = Locale(identifier: "en_SA")
        dateFormatter.dateFormat = "yyyy/MM/dd"
            fromCorresDateTF.text = dateFormatter.string(from: datePicker.date)
        toCorresDateTF.text = dateFormatter.string(from: datePicker.date)
        fromCorresDateTF.inputView = datePicker
        fromCorresDateTF.inputAccessoryView = toolbar
       
        toCorresDateTF.inputAccessoryView = toolbar
        toCorresDateTF.inputView = datePicker
        corresDateStackView.removeArrangedSubview(corresDateView)
       corresDateView.isHidden = true
        let obj = SendCorrespondenceModel.init()
        obj.sentCorrespondencesPeriod = 1
        obj.isSent = true
        obj.fromDate = "-1"
        obj.toDate = "-1"
        viewModel.getTodayInbox(Model: obj)
      
    }
    
    @objc fileprivate func handeleSegmentChange(){
        let obj = SendCorrespondenceModel.init()
        switch corresDateSegmentControll.selectedIndex {
        case 0:
             corresDateStackView.removeArrangedSubview(corresDateView)
            corresDateView.isHidden = true
            obj.sentCorrespondencesPeriod = 1
            obj.isSent = true
            obj.fromDate = "-1"
            obj.toDate = "-1"
            tableView.isHidden = false

          //  tableView.reloadData()
            viewModel.getTodayInbox(Model: obj)
           
            case 1:
                corresDateStackView.removeArrangedSubview(corresDateView)
                corresDateView.isHidden = true
                obj.sentCorrespondencesPeriod = 7
                obj.isSent = true
                obj.fromDate = "-1"
                obj.toDate = "-1"
                tableView.isHidden = false

                viewModel.getWeekInbox(Model: obj)
                sentArray = weekArray
            //   tableView.reloadData()


        case 2:
            corresDateStackView.removeArrangedSubview(corresDateView)
            corresDateView.isHidden = true
            obj.sentCorrespondencesPeriod = 30
            obj.isSent = true
            obj.fromDate = "-1"
            obj.toDate = "-1"
            tableView.isHidden = false

            viewModel.getMonthInbox(Model: obj)
           sentArray = monthArray
       // tableView.reloadData()

      
        case 3:
            corresDateStackView.addArrangedSubview(corresDateView)
            corresDateView.isHidden = false
            tableView.isHidden = true
        
        //    tableView.reloadData()

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
        if fromCorresDateTF.isFirstResponder {

            fromCorresDateTF.text = dateFormatter.string(from: datePicker.date)
            view.endEditing(true)
           }
        if toCorresDateTF.isFirstResponder {
             
            toCorresDateTF.text = dateFormatter.string(from: datePicker.date)
            view.endEditing(true)

           }
    }
    class func initializeFromStoryboard() -> SentCorrespondenceViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.SentCorrepondence, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: SentCorrespondenceViewController.self)) as! SentCorrespondenceViewController
    }



    //MARK: - SetUp ViewModel

    func setupViewModel() {
        
        viewModel.weekArray = { [unowned self] (optionArray) in
            self.weekArray = optionArray
           // print(sentArray)
        }
        
        viewModel.todayArray = { [unowned self] (optionArray) in
            self.sentArray = optionArray
           // print(sentArray)
        }
        
        viewModel.monthArray = { [unowned self] (optionArray) in
            self.monthArray = optionArray
            sentArray = monthArray
     print(monthArray)
        }
        
        viewModel.otherArray = { [unowned self] (optionArray) in
            self.otherArray = optionArray
          //  print(sentArray)
        }
            viewModel.startLoadingView = {
          self.progressView = loadingView.init(frame: self.view.frame)
          self.progressView.startAnimating()
          self.view.addSubview(self.progressView)
            }
        viewModel.presentTableView = { [self] in
            tableView.isHidden = false
        }
        
viewModel.stopLoadingView = {
  self.progressView.stopAnimating()
    self.progressView.removeFromSuperview()
}
        viewModel.reloadTableView = { [self] in
            tableView.reloadData()
        }

    }
    @IBAction func showResultBtn(_ sender: Any) {
       let obj = SendCorrespondenceModel.init()
        obj.sentCorrespondencesPeriod = -1
        obj.isSent = true
//        let fromDate = fromCorresDateTF.text?.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
//        let toDate = toCorresDateTF.text?.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
//         print(fromDate)
//         print(toDate)
        obj.fromDate = fromCorresDateTF.text //fromDate
        obj.toDate = toCorresDateTF.text
        viewModel.getOtherInbox(Model: obj)
        sentArray = otherArray
    }
    
}
// MARK:- UITableViewController DataSource

extension SentCorrespondenceViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        print(sentArray)
        var numOfSections: Int = 0
        if sentArray.count > 0 {
          //  tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }else{
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available".localized
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sentArray.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell2 = tableView.dequeueReusableCell(withIdentifier: "SentCorrespondenceTableViewCell", for: indexPath) as! SentCorrespondenceTableViewCell

        let dept = sentArray[indexPath.row]
        let str = "\(dept.correspondenceDate!)"

       let first10 = str.prefix(10)
        let type = "\(dept.correspondenceTypeName!)"

       let first5 = type.dropFirst(7)
        cell2.corressType.text = String(first5)
       cell2.corressTitle.text = dept.correspondenceSubject
       cell2.corressDate.text = String(first10)
        //////////////////////////
        
        cell2.corressNum.text = "\(dept.displayNumber!)"
        
//       cell2.deptName.text = dept.fromUser
//     //  cell2.ccImage.image = UIImage(named: "icon_cc")
//        if dept.stepType == 2 {
//            cell2.ccImage.image = UIImage(named: "icon_cc")
//        }else if dept.stepType == 3{
//            cell2.ccImage.image = UIImage(named: "icon_alarm")
//        }else if dept.stepType == 4 {
//            cell2.ccImage.image = UIImage(named: "unread")
//        }
//        if dept.locked ?? false {
//            cell2.lockedImage.image = UIImage(named: "unlockWhite")
//        }

        return cell2
    }


}


//MARK:- UITableViewController Delegate

extension SentCorrespondenceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }

}
