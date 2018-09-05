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
    
    let personCellIdentifier = "PeopleTableViewCell"
    
    var results:[PersonResult]?{
        didSet{
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PeopleTableViewCell.self, forCellReuseIdentifier: personCellIdentifier)
        
        searchController?.searchBar.placeholder = "Shows Search"
        
        searchController?.searchBar.delegate = self
        
        searchController?.searchBar.scopeButtonTitles = ["Shows", "People"]
        
        self.results = [PersonResult]()
        
    }
    
    
    func getData(search:String?) {
        
        self.refreshControl?.beginRefreshing()
        
        switch searchController?.searchBar.selectedScopeButtonIndex {
        case 0:
            Services.shared.searchShowByName(query: search){
                result, error in
                
                if error == nil {
                    self.items = result
                }
                
            }
        default:
            Services.shared.peopleSearch(query: search){
                result, error in
                
                if error == nil {
                    self.results = result
                }
                
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customLargeTitle(title:NSLocalizedString("Search", comment: ""))
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch searchController?.searchBar.selectedScopeButtonIndex {
        case 0:
            
            return items?.count ?? 0
        default:
            
            return results?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch searchController?.searchBar.selectedScopeButtonIndex {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell
            
            cell.showCellData = ShowTableViewCell.ShowCellData(show:items?[indexPath.row].show)
            
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: personCellIdentifier, for: indexPath) as! PeopleTableViewCell
            
            cell.peopleData = PeopleTableViewCell.PeopleData(person:results?[indexPath.row].person)
            
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch searchController?.searchBar.selectedScopeButtonIndex {
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            
            let detail = ShowDetailsViewController()
            
            detail.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row].show)
            
            self.navigationController?.pushViewController(detail, animated: true)
            
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            
            let detail = PersonDetailsViewController()
            
            detail.item = results?[indexPath.row].person
            
                //ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row].show)
            
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getData(search: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.items = [ShowResult]()
        self.results = [PersonResult]()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.items = [ShowResult]()
        self.results = [PersonResult]()
    }
}

