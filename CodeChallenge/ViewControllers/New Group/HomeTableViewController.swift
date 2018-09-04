//
//  HomeTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/1/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var items:[Show]?
    
    var currentPage:Int = 1
    
    let cellIdentifier = "ShowTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [Show]()
        
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        getData()
        
        
        let searchController = UISearchController(searchResultsController: nil)
        
        refreshControl = UIRefreshControl()
        
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        refreshControl?.addTarget(self, action: #selector(refresData), for: .valueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //Move somewhere else
    
    @objc private func refresData(_ sender: Any) {
        // Fetch Weather Data
        getData()
    }
    
    func getData() {
        
        Services.shared.retriveShowList(page: currentPage){
            (show, error) in
            self.items = show
            
            self.currentPage = Int((self.items?.count ?? 0) / 250)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addImageTitle(name: "gray-text-logo-smaller")
        
        customLargeTitle(title:NSLocalizedString("Home", comment: ""))
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
        
        cell.showCellData = ShowTableViewCell.ShowCellData(show:items?[indexPath.row])
            //ShowCellData(show:items?[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = ShowDetailsViewController()
        
        detail.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row])
        
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}
