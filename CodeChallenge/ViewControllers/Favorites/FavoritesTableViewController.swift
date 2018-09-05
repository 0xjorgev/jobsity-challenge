//
//  FavoritesTableViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class FavoritesTableViewController: GenericTableViewController<Show> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customLargeTitle(title:NSLocalizedString("Favorites", comment: ""))
        
        navigationItem.searchController = nil
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let show = DBManager.shared.getObjectById(id: self.items![indexPath.row].id!)
            
            DBManager.shared.deleteFromDb(object: show!)
            
            self.items?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func getData(){
        
        items = []
        
        let list = DBManager.shared.getDataFromDB()
        
        for item in list {
            
            Services.shared.retrieveShowBy(showId: item.showId){
                show, error in
                
                if error == nil {
                    
                    self.items?.append(show!)
                    
                    self.items = self.items?.sorted(by: { $0.name! < $1.name! })
                }
            }
        }
    }
    
}
