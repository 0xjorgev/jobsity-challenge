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

//extension HomeTableViewController:UISearchBarDelegate {
//
//}
