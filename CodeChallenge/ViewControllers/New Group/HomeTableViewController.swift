//
//  HomeTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/1/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class HomeTableViewController: GenericTableViewController<Show>, UISearchBarDelegate {
    
    var fetchingMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController?.searchBar.delegate = self
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if !fetchingMore {
               // beginBatchFetch()
                self.currentPage += 1
                self.getData()
            }
        }
    }
    
    override func getData() {
        
        fetchingMore = true
        
        
        Services.shared.retriveShowList(page: currentPage){
            (shows, error) in
            if error == nil {
                
                self.items! += shows!
                
                self.itemsCopy = self.items
                
                self.currentPage = Int((self.items?.count ?? 0) / 250)
                
                DispatchQueue.main.async{
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
                    self.fetchingMore = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customLargeTitle(title:NSLocalizedString("Home", comment: ""))
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        items = itemsCopy
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count != 0 {
            filterByText(item: searchBar.text ?? "")
        } else {
            items = itemsCopy
        }
    }
    
    func filterByText(item:String) {
        
        items = items?.filter{
            $0.name!.contains(item)
            } ?? []
    }

}

