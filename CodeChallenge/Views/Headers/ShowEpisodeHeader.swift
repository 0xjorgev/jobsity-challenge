//
//  ShowEpisodeHeader.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/3/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class ShowEpisodeHeader:UIView {
    
    var title:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(){
        
        title = UILabel()
        
        title?.font = UIFont.systemFont(ofSize: 22.0)
        
        title?.textColor = Colors.mainGreen
        
        title?.numberOfLines = 2
        
        self.addSubview(title!)
        
        self.backgroundColor = UIColor.groupTableViewBackground
        
        
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        title?.autoPinEdge(.top, to: .top, of: self, withOffset: 5.0)
        title?.autoPinEdge(.left, to: .left, of: self, withOffset: 24.0)
        title?.autoPinEdge(.right, to: .right, of: self, withOffset: -24.0)
        title?.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -5.0)
        
        //title?.autoSetDimension(.height, toSize: 65.0)
    }
    
}
