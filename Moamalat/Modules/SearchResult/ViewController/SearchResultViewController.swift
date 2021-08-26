//
//  SearchResultViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 22/12/1442 AH.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SearchResultViewModel()
    var searcResultArray = [SearchResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  viewModel.passData()
        setupViewModel()
        self.tableView.register(UINib(nibName: "PrivateTableViewCell", bundle: nil), forCellReuseIdentifier: "PrivateCell")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,
                                                                         for: .default)
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(addTapped), imageName: "back")
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        tableView.reloadData()
        print(searcResultArray)
        print(searcResultArray)
    }
    @objc func addTapped (){
        self.dismiss(animated:true, completion:nil);
        self.navigationController?.popViewController(animated:true)
    }
    //MARK: - SetUp ViewModel
    
    func setupViewModel() {
    
        viewModel.searcResultArray = { [unowned self] (optionArray) in
            self.searcResultArray = optionArray
            print(searcResultArray)
        }
        viewModel.reloadTableView    = { [unowned self]  in

           self.tableView.reloadData()
          //  refreshControl.endRefreshing()
       }
        viewModel.refreshControl    = { [unowned self]  in

          //  refreshControl.endRefreshing()
       }
    }
    
    
    class func initializeFromStoryboard() -> SearchResultViewController {
        
        let storyboard = UIStoryboard(name: Storyboards.SearchResult, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: SearchResultViewController.self)) as! SearchResultViewController
    }

}

// MARK:- UITableViewController DataSource

extension SearchResultViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
    
            if viewModel.searchResultModel.count > 0 {
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
        return viewModel.searchResultModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "PrivateCell", for: indexPath) as! PrivateTableViewCell
        let result = viewModel.searchResultModel
        let dept = result[indexPath.row]
       // let dept = searcResultArray[indexPath.row]
        let str = "\(dept.correspondenceDate!)"
       
      // let first10 = str.prefix(10)
        let type = "\(dept.correspondenceTypeName!)"
       
       let first5 = type.dropFirst(7)
        cell.corressType.text = String(first5)
       cell.corressTitle.text = dept.correspondenceSubject
       cell.corressDate.text = str
       cell.corressNum.text = dept.displayCorrespondenceId
       cell.deptName.text = dept.destinationName
      
        return cell
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
////        if indexPath.row + 1 == corressArr.count {
////            print("scrolled")
////            isFilter = true
////         viewModel.getPrivateInbox(isFilter: isFilter)
////        }
//    }
}
