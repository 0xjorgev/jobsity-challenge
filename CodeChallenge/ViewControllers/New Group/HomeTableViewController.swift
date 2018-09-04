//
//  HomeTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/1/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class HomeTableViewController: GenericTableViewController<Show>, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController?.searchBar.delegate = self
        
        //typealias FetchResult = Result<HackerNewsResponse, FetchError>
        
        // Set custom indicator
        //tableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        // Set custom indicator margin
        tableView.infiniteScrollIndicatorMargin = 40
        
        // Set custom trigger offset
        tableView.infiniteScrollTriggerOffset = 500
        
        // Add infinite scroll handler
        tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            self?.fetchData { show, error in
                
                tableView.finishInfiniteScroll()
            }
        }
        
        tableView.beginInfiniteScroll(true)
        
    }
    
    func fetchData(handler: @escaping ((Show, Error) -> Void)) {

        Services.shared.retriveShowList(page: currentPage){
            (show, error) in
            
            //self.currentPage = Int((self.items?.count ?? 0) / 250) + 1
            
            // create new index paths
            let (start, end) = (self.items!.count, show!.count + self.items!.count)
            let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
            
            // update data source
            self.items! += show!
            self.itemsCopy = self.items
            self.currentPage += 1
            
            //Approachs are willDisplayCell
            
            // update table view
            OperationQueue.main.addOperation {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .automatic)
                self.tableView.endUpdates()
            }   
        }
    }
    
    override func getData() {
        
        Services.shared.retriveShowList(page: currentPage){
            (show, error) in
            
            self.items = show
            
            self.itemsCopy = show
            
            self.currentPage = Int((self.items?.count ?? 0) / 250) + 1
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

