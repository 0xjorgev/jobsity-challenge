//
//  ShowEpisodeTableViewCell.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/3/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class ShowEpisodeTableViewCell:UITableViewCell {
    
    var poster:UIImageView?
    
    var name:UILabel?
    
    var season:UILabel?
    
    var number:UILabel?
    
    
    struct ShowEpisodeCellData {
        
        let episode:Episode?
    }
    
    var showEpisodeCellData: ShowEpisodeCellData? {
        didSet{
            
            
            name?.text = showEpisodeCellData?.episode?.name ?? ""

            season?.text = "Season: \(showEpisodeCellData?.episode?.season ?? 0)"

            number?.text = "Number: \(showEpisodeCellData?.episode?.number ?? 0)"
            
            poster?.image = UIImage(named: "empty-image")
            
            poster?.moa.onSuccess = { image in
                return image
            }
            
            poster?.moa.url = showEpisodeCellData?.episode?.image?.medium
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func createViews(){
        
        let emptyImage = UIImage(named: "empty-image")
        
        poster = UIImageView(image: emptyImage)
        
        poster?.contentMode = .scaleAspectFit
        
        self.addSubview(poster!)
        
        
        name = UILabel()
        
        name?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        name?.textColor = .black
        
        name?.numberOfLines = 2
        
        self.addSubview(name!)
        
        
        season = UILabel()
        
        season?.font = UIFont.systemFont(ofSize: 14.0)
        
        season?.textColor = .black
        
        self.addSubview(season!)
        
        
        number = UILabel()
        
        number?.font = UIFont.systemFont(ofSize: 14.0)
        
        number?.textColor = .black
        
        self.addSubview(number!)
        
        
        self.accessoryType = .disclosureIndicator
        
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        let imageHeight:CGFloat = CGFloat(108.0)
        let scaleFactor:CGFloat = CGFloat(0.7118)
        
        poster?.autoPinEdge(.top, to: .top, of: self, withOffset: 5.0)
        poster?.autoPinEdge(.left, to: .left, of: self, withOffset: 5.0)
        poster?.autoSetDimension(.height, toSize: imageHeight)
        poster?.autoSetDimension(.width, toSize: (imageHeight * scaleFactor))
        
        name?.autoPinEdge(.top, to: .top, of: self, withOffset: 25.0)
        name?.autoPinEdge(.left, to: .left, of: self, withOffset: 86.0)
        name?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        number?.autoPinEdge(.top, to: .bottom, of: name!, withOffset: 5.0)
        number?.autoPinEdge(.left, to: .left, of: self, withOffset: 86.0)
        number?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        season?.autoPinEdge(.top, to: .bottom, of: number!, withOffset: 5.0)
        season?.autoPinEdge(.left, to: .left, of: self, withOffset: 86.0)
        season?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
    }
    
}

