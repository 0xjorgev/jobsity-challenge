//
//  ShowDetailsViewController.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/2/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UITableViewController {
    
    let summaryIdentifier = "ShowSummaryTableViewCell"
    
    let episodeIdentifier = "ShowEpisodeTableViewCell"
    
    var header:ShowDetailHeaderView?
    
    var items:[Season]?{
        didSet{
            //print("Items Count: \(items?.count ?? 0)")
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    struct ShowDetailData {
        let show:Show?
    }
    
    var showDetailData:ShowDetailData? {
        didSet{
            //print("Show ID: \(showDetailData?.show?.id ?? 0)")
            
            self.getData(showId: showDetailData?.show?.id ?? 0)
            
            let width = UIScreen.main.bounds.width
            
            header = ShowDetailHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 210.0))
            
            header?.headerData = ShowDetailHeaderView.HeaderData(show: showDetailData?.show )
            
            tableView.tableHeaderView = header
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ShowSummaryTableViewCell.self, forCellReuseIdentifier: summaryIdentifier)
        
        tableView.register(ShowEpisodeTableViewCell.self, forCellReuseIdentifier: episodeIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addImageTitle(name: "gray-text-logo-smaller")
        customSmallNavBar()
        self.view.backgroundColor = .white
    }
    
    func getData(showId:Int?){
        Services.shared.seasonsByShow(showId: showId!){
            seasons, error in
            
            if error == nil {
//                print("Shows: \(seasons?.count ?? 0)")
                
                self.items = [Season]()
                
                for season in seasons! {
                    Services.shared.episodeListBySeason(seasonId: season.id){
                        episodes, error in
                        
//                        print("Episodes Count: \(episodes?.count ?? 0)")
                        
                        if error == nil {
                            
                            let filled = Season(season:season, episodes:episodes!)
                            //print("Filled: \(filled)")
                            self.items?.append(filled)
                            self.items = self.items?.sorted(by: { $0.number! < $1.number! })
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (items?.count ?? 0) + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch  section {
            case 0: return 1
            default: return (items?[section - 1].episodes?.count ?? 0)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch  section {
        case 0: return UIView()
        default:
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 115.0)
            
            let header = ShowEpisodeHeader(frame: frame)
            
            header.title?.text = "Season \(self.items?[section - 1].number ?? 0) \(self.items?[section - 1].name ?? "")"
            
            return header
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch  (indexPath.section, indexPath.row) {
        case (0,_):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: summaryIdentifier, for: indexPath) as! ShowSummaryTableViewCell
            
            cell.setupContent(title: NSLocalizedString("Summary", comment: ""), content: self.showDetailData?.show?.summary ?? "")
            
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: episodeIdentifier, for: indexPath) as! ShowEpisodeTableViewCell
            
            cell.showEpisodeCellData = ShowEpisodeTableViewCell.ShowEpisodeCellData(episode: items?[indexPath.section - 1].episodes?[indexPath.row])
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            case 0: return self.estimateSummaryHeigth(content: self.showDetailData?.show?.summary ?? "")
            default: return 115.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let episodeDetail = EpisodeDetailViewController()
        
        episodeDetail.item = items?[indexPath.section - 1].episodes?[indexPath.row]
        
        self.navigationController?.pushViewController(episodeDetail, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
