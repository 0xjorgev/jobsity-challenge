//
//  GenericTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class GenericTableViewController<T>: UITableViewController {
    
    var items:[T]?{
        didSet{
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    var itemsCopy:[T]?
    
    var filteredItems:[T]?
    
    var currentPage:Int = 0
    
    var searchController:UISearchController?
    
    //var refreshControl:UIRefreshControl?
    
    open var cellIdentifier = "ShowTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [T]()
        
        itemsCopy = [T]()
        
        filteredItems = [T]()
        
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        searchController = UISearchController(searchResultsController: nil)
        
        self.refreshControl = UIRefreshControl()
        
        navigationItem.searchController = searchController
        
        searchController?.obscuresBackgroundDuringPresentation = false
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        refreshControl?.addTarget(self, action: #selector(refresData), for: .valueChanged)
        
        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addImageTitle(name: "gray-text-logo-smaller")
    }

    @objc func refresData(_ sender: Any) {
        // Fetch Weather Data
        getData()
    }
    
    func getData() { }
    
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
        
        cell.showCellData = ShowTableViewCell.ShowCellData(show:items?[indexPath.row] as? Show)
        //ShowCellData(show:items?[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = ShowDetailsViewController()
        
        detail.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row] as? Show)
        
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}
