//
//  PersonDetailsViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailsViewController:UITableViewController{
    
   // let summaryIdentifier = "ShowSummaryTableViewCell"
    
    let cellIdentifier = "ShowTableViewCell"
    
    var header:PeopleHeaderView?
    
    var item:Person?{
        didSet{
            
            let width = UIScreen.main.bounds.width
            
            header = PeopleHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 275.0))
            
            header?.headerData = PeopleHeaderView.HeaderData(person: item )
            
            tableView.tableHeaderView = header
            
            getData(personId: item?.id ?? 0)
            
        }
    }
    
    var items:[Show]? {
        didSet{
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ShowTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addImageTitle(name: "gray-text-logo-smaller")
        customSmallNavBar()
        self.view.backgroundColor = .white
    }
    
    func getData(personId:Int){
        
        items = [Show]()
        
        Services.shared.retrieveShowBy(peopleId: personId){
            shows, error in
            
            if error == nil {
                
                self.items = shows.map{ return $0.map{
                    return ($0.embeded?.show)!
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 0
    
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45.0)
        
        let header = ShowEpisodeHeader(frame: frame)
        
        header.title?.text = "Shows related to person"
        
        return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShowTableViewCell
        
        cell.showCellData = ShowTableViewCell.ShowCellData(show: items?[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let showView = ShowDetailsViewController()
        
        showView.showDetailData = ShowDetailsViewController.ShowDetailData(show: items?[indexPath.row])
        
        self.navigationController?.pushViewController(showView, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120.0
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    
}
