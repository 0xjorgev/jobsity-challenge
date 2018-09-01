//
//  ShowTableViewCell.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/1/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    weak var poster:UIImageView?
    
    weak var title:UILabel?
    
    weak var language:UILabel?
    
    weak var status:UILabel?
    
    weak var type:UILabel?
    
    struct ShowCellData {
        
        let show:Show?
    }
    
    var showCellData: ShowCellData? {
        didSet{
            
        }
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
        
    }
    
    func setupConstraints(){
        
    }

}
