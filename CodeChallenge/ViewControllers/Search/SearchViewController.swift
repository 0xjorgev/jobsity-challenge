//
//  SearchViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/3/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController:UITableViewController {
    
    var items:[ShowResult]? {
        didSet{
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        }
    }
    
    let cellIdentifier = "ShowTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [ShowResult]()
        
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Shows Search"
        
        searchController.searchBar.delegate = self
        
        refreshControl = UIRefreshControl()
        
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
         definesPresentationContext = true
        
    }
    
    
    func getData(search:String?) {
        
        Services.shared.searchShowByName(query: search){
            result, error in
            
            self.items = result
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addImageTitle(name: "gray-text-logo-smaller")
        
        customLargeTitle(title:NSLocalizedString("Search", comment: ""))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell
        
        cell.showCellData = ShowTableViewCell.ShowCellData(show:items?[indexPath.row].show)
        //ShowCellData(show:items?[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = ShowDetailsViewController()
        
        detail.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row].show)
        
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getData(search: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.items = [ShowResult]()
    }
}
