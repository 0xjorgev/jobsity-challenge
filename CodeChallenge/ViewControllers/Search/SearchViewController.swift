//
//  SearchViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/3/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController:GenericTableViewController<ShowResult>,  UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController?.searchBar.placeholder = "Shows Search"
        
        searchController?.searchBar.delegate = self
        
        //refreshControl?.removeTarget(self, action: #selector(refresData), for: .valueChanged)
    }
    
    
    func getData(search:String?) {
        
        self.refreshControl?.beginRefreshing()
        
        Services.shared.searchShowByName(query: search){
            result, error in
            
            self.items = result
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customLargeTitle(title:NSLocalizedString("Search", comment: ""))
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell

        cell.showCellData = ShowTableViewCell.ShowCellData(show:items?[indexPath.row].show)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)

        let detail = ShowDetailsViewController()

        detail.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row].show)

        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getData(search: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.items = [ShowResult]()
    }
}

