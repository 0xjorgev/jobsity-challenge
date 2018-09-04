//
//  ShowSummaryTableViewCell.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/2/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class ShowSummaryTableViewCell: UITableViewCell {
    
    var title:UILabel?
    
    var content:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(){
    
        title = UILabel()
        
        //Add to constant files
        title?.font = UIFont.boldSystemFont(ofSize: 22.0)
        
        title?.textColor = Colors.mainGreen
        
        self.addSubview(title!)
        
        
        content = UILabel()
        
        //Add to constant files
        content?.font = UIFont.systemFont(ofSize: 14.0)
        
        content?.textColor = Colors.gray
        
        content?.numberOfLines = 0
        
        content?.textAlignment = .justified
        
        self.addSubview(content!)
        
        setupConstrains()
        
    }
    
    func setupConstrains(){
        
        title?.autoPinEdge(.top, to: .top, of: self, withOffset: 8.0)
        title?.autoPinEdge(.left, to: .left, of: self, withOffset: 8.0)
        title?.autoPinEdge(.right, to: .right, of: self, withOffset: -8.0)
        title?.autoSetDimension(.height, toSize: 35.0)
        
        content?.autoPinEdge(.top, to: .bottom, of: title!, withOffset: 8.0)
        content?.autoPinEdge(.left, to: .left, of: self, withOffset: 12.0)
        content?.autoPinEdge(.right, to: .right, of: self, withOffset: -12.0)
        content?.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -5.0)
        
    }
    
    func setupContent(title:String, content:String){
        self.title?.text = title
        self.content?.text = content.removeHTMLTags().count != 0 ? content.removeHTMLTags() : NSLocalizedString("No summary available", comment: "")
    }

}
