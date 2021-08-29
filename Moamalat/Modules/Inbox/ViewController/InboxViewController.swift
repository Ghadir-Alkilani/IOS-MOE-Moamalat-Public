//
//  InboxViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 01/12/1442 AH.
//

import UIKit

class InboxViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var allLable: UILabel!
    @IBOutlet weak var lateLable: UILabel!
    @IBOutlet weak var imagesLble: UILabel!
    @IBOutlet weak var unreadLable: UILabel!
    @IBOutlet weak var importantLable: UILabel!
    @IBOutlet weak var urgentImportantLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NowLable: UILabel!
    @IBOutlet weak var urgentLable: UILabel!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var firstFilterView: UIView!
    @IBOutlet weak var secondFilterView: UIView!
    @IBOutlet weak var nowBtn: UIButton!
    @IBOutlet weak var urgentbtn: UIButton!
    @IBOutlet weak var urgentImportantBtn: UIButton!
    @IBOutlet weak var importantBtn: UIButton!
    @IBOutlet weak var unreadBtn: UIButton!
    @IBOutlet weak var ccBtn: UIButton!
    @IBOutlet weak var lateBtn: UIButton!
    @IBOutlet weak var allbtn: UIButton!
    @IBOutlet weak var unreadCountLable: UILabel!
    @IBOutlet weak var ccLable: UILabel!
    @IBOutlet weak var halfTimeLable: UILabel!
    
    @IBOutlet weak var CreateCorrespondenceBtn: UIButton!
    @IBOutlet weak var segmentControll:
        CustomSegmentedControl! {
        
        didSet{
            segmentControll.setButtonTitles(buttonTitles: ["inbox_private_correspondence".localized,"inbox_public_correspondence".localized])
            
        }
    }
    
    //MARK: - Variables
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
            for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    var progressView = loadingView()
    var corressArr = [PrivateInboxModel]()
    
    var allArr = [PrivateInboxModel]()
    var unreadArray = [PrivateInboxModel]()
    var delayArray = [PrivateInboxModel]()
    var ccArray = [PrivateInboxModel]()
    var importantArray = [PrivateInboxModel]()
    var urgentArray = [PrivateInboxModel]()
    var urgentImportantArray = [PrivateInboxModel]()
    var nowArray = [PrivateInboxModel]()
    var recievePubInArr = [publicInbox]()
    var countsDic = [String:Any]()
    let viewModel = InboxViewModel()
    var filterArray = NSArray()
    var isFilter = false
    var start = 1
    var end = 20
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyLayout()
        applyFonts()
        viewModel.getpublicInbox()
        viewModel.getPrivateInbox(isFilter: isFilter , startRow: start , endRow: end )
        viewModel.getCounts()
//        viewModel.getCCInbox()
//        viewModel.getNowInbox()
//        viewModel.getUrgentInbox()
//        viewModel.getDelayInbox()
//        viewModel.getUnreadInbox()
//        viewModel.getImportantInbox()
//        viewModel.getUrgentImportantInbox()
        setupViewModel()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
   
    }
    
    //MARK: - Helper Method
    
    func applyFonts() {
        allLable.text = "all".localized
        unreadLable.text = "unread".localized
        imagesLble.text = "CC".localized
        lateLable.text = "halfTime".localized
        allLable.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        unreadLable.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        imagesLble.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        lateLable.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        importantLable.text = "impotant".localized
        NowLable.text = "now".localized
        urgentLable.text = "urgent".localized
        urgentImportantLable.text = "importantUrgent".localized
    }
    
    func applyLayout() {
        CreateCorrespondenceBtn.isHidden = true
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem.menuButton( self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), imageName:  "list")
       // self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        filterStackView.removeArrangedSubview(secondFilterView)
        secondFilterView.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(changeFilter), imageName: "filter")
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 200, y: 70)
          //  label.frame.origin.x
        label.center = self.view.center
        label.textAlignment = .center
        label.textColor = .white
        label.text = "my_correspondence".localized
        label.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        tableView.addSubview(refreshControl)
        self.tableView.register(UINib(nibName: "PublicInboxTableViewCell", bundle: nil), forCellReuseIdentifier: "publicCell")
        self.tableView.register(UINib(nibName: "PrivateTableViewCell", bundle: nil), forCellReuseIdentifier: "PrivateCell")
        self.view.addSubview(label)
        segmentControll.addTarget(self, action: #selector(handeleSegmentChange), for: .valueChanged)
    }
    
    //MARK: - SetUp ViewModel
    
    func setupViewModel() {
        viewModel.startLoadingView = {
            self.progressView = loadingView.init(frame: self.view.frame)
            self.progressView.startAnimating()
            self.view.addSubview(self.progressView)
        }
        viewModel.stopLoadingView = { [weak self] in
            self?.progressView.stopAnimating()
            self?.progressView.removeFromSuperview()
        }
       

        viewModel.presentViewController = { [unowned self] (vc) in
            
            self.present(vc, animated: true, completion: nil)
        }
        viewModel.privateArray = { [unowned self] (optionArray) in
            if isFilter{
                self.corressArr.append(contentsOf: optionArray)
              //self.allArr.append(contentsOf: optionArray)
            }else{
                self.corressArr = optionArray
            }
            self.allArr = optionArray

//            print(corressArr)
//                tableView.reloadData()
//               print(corressArr)
            
        }
        
        viewModel.delayArray = { [unowned self] (optionArray) in
           
                self.delayArray = optionArray
            corressArr = optionArray
        }
        viewModel.unreadArray = { [unowned self] (optionArray) in
           
                self.unreadArray = optionArray
            corressArr = optionArray
            
        }
        viewModel.nowArray = { [unowned self] (optionArray) in
           
                self.nowArray = optionArray
            corressArr = optionArray
            
        }
        viewModel.CCArray = { [unowned self] (optionArray) in
           
                self.ccArray = optionArray
            corressArr = optionArray
            
        }
        viewModel.importantArray = { [unowned self] (optionArray) in
           
                self.importantArray = optionArray
          
            corressArr = optionArray
        }
        viewModel.urgentImportantArray = { [unowned self] (optionArray) in
           
                self.urgentImportantArray = optionArray
            corressArr = optionArray
            
        }
        
        viewModel.urgentArray = { [unowned self] (optionArray) in
           
                self.urgentArray = optionArray
            corressArr = optionArray
            
        }
                viewModel.reloadTableView    = { [unowned self]  in
        
                   self.tableView.reloadData()
               }
                viewModel.refreshControl    = { [unowned self]  in
        
                    refreshControl.endRefreshing()
               }
        
                viewModel.inboxArray = { [unowned self] (optionArray) in
                    self.recievePubInArr = optionArray
                    tableView.reloadData()
                   print(recievePubInArr)
        
                }
        
        viewModel.countsDic = { [unowned self] (Dic) in
            self.countsDic = Dic
            print(countsDic)
             unreadCountLable.text = countsDic["UnreadCount"] as? String
            self.ccLable.text = countsDic["ccCount"] as? String
            self.halfTimeLable.text = countsDic["halfTimeCount"] as? String

        }
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        switch segmentControll.selectedIndex {
        case 0:
            print("0")
            if allbtn.isSelected{
                viewModel.getPrivateInbox(isFilter: isFilter , startRow: start , endRow: end)
            } else  if ccBtn.isSelected{
                viewModel.getCCInbox()
            }else if nowBtn.isSelected {
                viewModel.getNowInbox()
            }else if lateBtn.isSelected {
                viewModel.getDelayInbox()
            }else if unreadBtn.isSelected{
                viewModel.getUnreadInbox()
            }else if importantBtn.isSelected {
                viewModel.getImportantInbox()
            }else if urgentImportantBtn.isSelected{
                viewModel.getUrgentImportantInbox()
            }else if urgentbtn.isSelected {
                viewModel.getUrgentImportantInbox()
            }
        case 1:
            print("1")
            viewModel.getpublicInbox()
         
        default:
            print("done")
        }
        
    }


    @objc fileprivate func handeleSegmentChange(){
        switch segmentControll.selectedIndex {
        case 0:
            filterStackView.removeArrangedSubview(secondFilterView)
            secondFilterView.isHidden = true
            filterStackView.addArrangedSubview(firstFilterView)
            firstFilterView.isHidden = false
            tableView.reloadData()
            case 1:
                filterStackView.removeArrangedSubview(firstFilterView)
                firstFilterView.isHidden = true
                filterStackView.removeArrangedSubview(secondFilterView)
                secondFilterView.isHidden = true
            tableView.reloadData()
           //     inboxArr = corressArr as! NSMutableArray
        default:
            print("d")
        }
      
    }
    
    @objc func changeFilter (){
        privateFilterView()
    }
    
    //MARK: - Initialization
    
    class func initializeFromStoryboard() -> InboxViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.Inbox, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: InboxViewController.self)) as! InboxViewController
    }
    
    func privateFilterView(){
        if firstFilterView.isHidden {
            filterStackView.removeArrangedSubview(secondFilterView)
            secondFilterView.isHidden = true
            filterStackView.addArrangedSubview(firstFilterView)
            firstFilterView.isHidden = false
            
        }else{
           
           filterStackView.removeArrangedSubview(firstFilterView)
            firstFilterView.isHidden = true
            filterStackView.addArrangedSubview(secondFilterView)
            secondFilterView.isHidden = false
    }
    }
    
    //MARK: - Actions
    
    @IBAction func createCorresAction(_ sender: Any) {
        let vc = CreateCorrespondenceViewController.initializeFromStoryboard()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {

       viewModel.getCounts()
        if segmentControll.selectedIndex == 0 {
        switch sender.tag {
        case 0:
            allbtn.isSelected = true
            unreadBtn.isSelected = false
            lateBtn.isSelected = false
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = false
            ccBtn.isSelected = false
            nowBtn.isSelected = false
           // corressArr = allArr
            viewModel.getPrivateInbox(isFilter: false, startRow: 1, endRow: 20)
         //   tableView.reloadData()
            
        case 1:
            allbtn.isSelected = false
            unreadBtn.isSelected = false
            lateBtn.isSelected = true
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = false
            ccBtn.isSelected = false
            nowBtn.isSelected = false
     //  corressArr = delayArray
            viewModel.getDelayInbox()
   //    tableView.reloadData()

        case 2:
            allbtn.isSelected = false
            unreadBtn.isSelected = false
            lateBtn.isSelected = false
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = false
            ccBtn.isSelected = true
            nowBtn.isSelected = false
         //   corressArr = ccArray
            viewModel.getCCInbox()
           // tableView.reloadData()

        case 3:
            allbtn.isSelected = false
            unreadBtn.isSelected = true
            lateBtn.isSelected = false
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = false
            ccBtn.isSelected = false
            nowBtn.isSelected = false
            viewModel.getUnreadInbox()
           // tableView.reloadData()
        case 4:
            allbtn.isSelected = false
            unreadBtn.isSelected = false
            lateBtn.isSelected = false
            importantBtn.isSelected = true
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = false
            ccBtn.isSelected = false
            nowBtn.isSelected = false
            viewModel.getImportantInbox()
          //  corressArr = importantArray
          //  tableView.reloadData()
        case 5:
            allbtn.isSelected = false
            unreadBtn.isSelected = false
            lateBtn.isSelected = false
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = true
            urgentbtn.isSelected = false
            ccBtn.isSelected = false
            nowBtn.isSelected = false
            viewModel.getUrgentImportantInbox()
           // corressArr = urgentArray
          // tableView.reloadData()
        case 6:
            allbtn.isSelected = false
            unreadBtn.isSelected = false
            lateBtn.isSelected = false
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = true
            ccBtn.isSelected = false
            nowBtn.isSelected = false
            viewModel.getUrgentInbox()
         //   corressArr = urgentImportantArray
          //  tableView.reloadData()
        case 7:
            allbtn.isSelected = false
            unreadBtn.isSelected = false
            lateBtn.isSelected = false
            importantBtn.isSelected = false
            urgentImportantBtn.isSelected = false
            urgentbtn.isSelected = false
            ccBtn.isSelected = false
            nowBtn.isSelected = true
            viewModel.getNowInbox()
          //  corressArr = nowArray
        //    tableView.reloadData()
        default:
          print("done")
        }
    }
    }
    
}


// MARK:- UITableViewController DataSource

extension InboxViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if segmentControll.selectedIndex == 0{
            if corressArr.count > 0 {
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
               
        }else {
            if recievePubInArr.count > 0 {
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
        }
        
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0

           switch(segmentControll.selectedIndex)
           {
           case 0:
            returnValue = corressArr.count

               break
           case 1:
            returnValue = recievePubInArr.count
               break
           default:
               break

           }
           return returnValue
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell2 = tableView.dequeueReusableCell(withIdentifier: "PrivateCell", for: indexPath) as! PrivateTableViewCell
        let  cell = tableView.dequeueReusableCell(withIdentifier: "publicCell", for: indexPath) as! PublicTableViewCell
      if  segmentControll.selectedIndex == 0 {
        if corressArr.count != 0{
            
        }
        
        let dept = corressArr[indexPath.row]
        let str = "\(dept.receivedOnHijriDate!)"
       
        let first10 = str.prefix(10)
        let type = "\(dept.correspondenceTypeName!)"
       
        let first5 = type.dropFirst(7)
        cell2.corressType.text = String(first5)
        cell2.corressTitle.text = dept.subject
        cell2.corressDate.text = String(first10)
        cell2.corressNum.text = dept.displayCorrespondenceId
        cell2.deptName.text = dept.fromUser
     //  cell2.ccImage.image = UIImage(named: "icon_cc")
        if dept.stepType == 2 {
            cell2.ccImage.image = UIImage(named: "icon_cc")
        }else if dept.stepType == 3{
            cell2.ccImage.image = UIImage(named: "icon_alarm")
        }else if dept.stepType == 4 {
            cell2.ccImage.image = UIImage(named: "unread")
        }
        if dept.locked ?? false {
            cell2.lockedImage.image = UIImage(named: "unlockWhite")
        }
      } else{
        
    let dept = recievePubInArr[indexPath.row]
    cell.depNameLable.text = dept.departmentNameAr

        return cell
      }
        return cell2
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == corressArr.count {
            print("scrolled")
            isFilter = true
        }
    }
}


//MARK:- UITableViewController Delegate

extension InboxViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentControll.selectedIndex == 0 {
        }else{
            let obj = recievePubInArr[indexPath.row]
            let vc = PublicInboxViewController.initializeFromStoryboard()
            vc.queueName = obj.queueName ?? ""
            vc.inbasketFilter = obj.inbasketFilter ?? ""
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .overFullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }

}


