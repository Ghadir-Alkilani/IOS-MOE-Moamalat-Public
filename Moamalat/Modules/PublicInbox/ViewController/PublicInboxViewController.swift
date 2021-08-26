//
//  PublicInboxViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 19/12/1442 AH.
//

import UIKit
class PublicInboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
            for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    var queueName = String()
    var inbasketFilter = String()
    
    var corressArr = [PrivateInboxModel]()
    
 let viewModel = PublicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(addTapped))
        print(queueName)
        print(inbasketFilter)
        self.tableView.register(UINib(nibName: "PrivateTableViewCell", bundle: nil), forCellReuseIdentifier: "PrivateCell")
        viewModel.getPrivateInbox(queueName: queueName, inbasketFilter: inbasketFilter)
        setupViewModel()
    }
    
    @objc func addTapped (){
        self.dismiss(animated:true, completion:nil);
        self.navigationController?.popViewController(animated:true)
    }
    
    func setupViewModel() {

        viewModel.presentViewController = { [unowned self] (vc) in

            self.present(vc, animated: true, completion: nil)
        }
        viewModel.privateArray = {
            [unowned self] (optionArray) in
                self.corressArr = optionArray
            print(corressArr)
                tableView.reloadData()
            
        }
                viewModel.reloadTableView    = { [unowned self]  in

                   self.tableView.reloadData()
                  //  refreshControl.endRefreshing()
               }
                viewModel.refreshControl    = { [unowned self]  in

                    refreshControl.endRefreshing()
               }
    }
    
    class func initializeFromStoryboard() -> PublicInboxViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.PublicInbox, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: PublicInboxViewController.self)) as! PublicInboxViewController
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    }

}


// MARK:- UITableViewController DataSource

extension PublicInboxViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if corressArr.count > 0 {
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
  
           return corressArr.count
       
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell2 = tableView.dequeueReusableCell(withIdentifier: "PrivateCell", for: indexPath) as! PrivateTableViewCell
        
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

        return cell2
    }


}


//MARK:- UITableViewController Delegate

extension PublicInboxViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
    }

}


