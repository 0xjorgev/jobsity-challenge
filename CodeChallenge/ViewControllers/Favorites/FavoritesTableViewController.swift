//
//  FavoritesTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let cellIdentifier = "ShowTableViewCell"
    
    var items:[Show]?{
        didSet{
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [Show]()
        
        self.tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        definesPresentationContext = true
        
        refreshControl?.addTarget(self, action: #selector(refresData), for: .valueChanged)
    }
    
    @objc private func refresData(_ sender: Any) {
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
        
        addImageTitle(name: "gray-text-logo-smaller")
        
        customLargeTitle(title:NSLocalizedString("Favorites", comment: ""))
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

    
    func getData(){
        
        items = [Show]()
        
        let list = DBManager.shared.getDataFromDB()
        
        for item in list {
            
            Services.shared.retrieveShowBy(showId: item.showId){
                show, error in
                
                //print("Show search: \(show)")
                
                if error == nil {
                    
                    self.items?.append(show!)
                    
                    self.items = self.items?.sorted(by: { $0.name! < $1.name! })
                    
                }
                
            }
        }
    }

}
