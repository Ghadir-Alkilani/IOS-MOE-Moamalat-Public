//
//  SearchResultViewController.swift
//  Moamalat
//
//  Created by Ghadir kilani on 22/12/1442 AH.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    let viewModel = SearchResultViewModel()
    var searcResultArray = [SearchResultModel]()
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        applyLayout()
    }
    
    //MARK: - Helper Methods
    
    func applyLayout() {
        self.tableView.register(UINib(nibName: "PrivateTableViewCell", bundle: nil), forCellReuseIdentifier: "PrivateCell")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "header") ,
                                                                         for: .default)
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(addTapped), imageName: "back")
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        tableView.reloadData()
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
       }
       
    }
    
    
    //MARK: - Initialization
    
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
        let str = "\(dept.correspondenceDate!)"
        let type = "\(dept.correspondenceTypeName!)"
        let first5 = type.dropFirst(7)
        cell.corressType.text = String(first5)
        cell.corressTitle.text = dept.correspondenceSubject
        cell.corressDate.text = str
        cell.corressNum.text = dept.displayCorrespondenceId
        cell.deptName.text = dept.destinationName
        return cell
    }

}
