//
//  SearchResultViewModel.swift
//  Moamalat
//
//  Created by Ghadir kilani on 22/12/1442 AH.
//

import Foundation
import UIKit


class SearchResultViewModel: BaseViewModel  {
    var searcResultArray : ((_ array: [SearchResultModel]) -> ())?
     var searchResultModel = [SearchResultModel]()
    var reloadTableView : (()->())?
    var refreshControl: (() -> ())?
    func passData(){
        self.reloadTableView?()
    self.searcResultArray?(searchResultModel)
        print(searchResultModel)
        print(searchResultModel)

    }
}
