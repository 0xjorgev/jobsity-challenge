//
//  EpisodeDetailViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/3/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UITableViewController {

    let summaryIdentifier = "ShowSummaryTableViewCell"
    
    var header:EpisodeDetailHeader?
    
    var item:Episode?{
        didSet{
            //print("Items Count: \(items?.count ?? 0)")
            
            let width = UIScreen.main.bounds.width
            
            header = EpisodeDetailHeader(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 235.0))
            
            header?.headerData = EpisodeDetailHeader.HeaderData(episode: item )
            
            tableView.tableHeaderView = header
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ShowSummaryTableViewCell.self, forCellReuseIdentifier: summaryIdentifier)
        
        //tableView.register(ShowEpisodeTableViewCell.self, forCellReuseIdentifier: episodeIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addImageTitle(name: "gray-text-logo-smaller")
        customSmallNavBar()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch  section {
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch  section {
        case 0: return UIView()
        default:
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 235.0)
            
            let header = ShowEpisodeHeader(frame: frame)
            
            //header.title?.text = "Season \(self.items?[section - 1].number ?? 0) \(self.items?[section - 1].name ?? "")"
            
            return header
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch  (indexPath.section, indexPath.row) {
        
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: summaryIdentifier, for: indexPath) as! ShowSummaryTableViewCell
            
            cell.setupContent(title: NSLocalizedString("Summary", comment: ""), content: self.item?.summary ?? NSLocalizedString("No summary available", comment: ""))
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        default: return self.estimateSummaryHeigth(content: self.item?.summary ?? "")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}
