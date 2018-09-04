//
//  ShowTableViewCell.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/1/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import UIKit
import PureLayout
import moa

class ShowTableViewCell: UITableViewCell {
    
    var poster:UIImageView?
    
    var title:UILabel?
    
    var language:UILabel?
    
    var status:UILabel?
    
    var type:UILabel?
    
    struct ShowCellData {
        
        let show:Show?
    }
    
    var showCellData: ShowCellData? {
        didSet{
            
            title?.text = showCellData?.show?.name ?? ""
            
            language?.text = showCellData?.show?.language ?? ""
            
            status?.text = showCellData?.show?.status ?? ""
            
            type?.text = showCellData?.show?.type ?? ""
            
            poster?.image = UIImage(named: "empty-image")
            
            poster?.moa.onSuccess = { image in
                return image
            }
            
            poster?.moa.url = showCellData?.show?.image?.medium
            
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
        
        
        title = UILabel()
        
        title?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        title?.textColor = .black
        
        self.addSubview(title!)
        
        
        language = UILabel()
        
        language?.font = UIFont.systemFont(ofSize: 14.0)
        
        language?.textColor = .black
        
        self.addSubview(language!)
        
        
        status = UILabel()
        
        status?.font = UIFont.systemFont(ofSize: 12.0)
        
        status?.textColor = .black
        
        self.addSubview(status!)
        
        
        type = UILabel()
        
        type?.font = UIFont.systemFont(ofSize: 12.0)
        
        type?.textColor = .black
        
        self.addSubview(type!)
        
        
        self.accessoryType = .disclosureIndicator
        
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        let imageHeight:CGFloat = CGFloat(108.0)
        let scaleFactor:CGFloat = CGFloat(0.7118)
        
        poster?.autoPinEdge(.top, to: .top, of: self, withOffset: 5.0)
        poster?.autoPinEdge(.left, to: .left, of: self, withOffset: 5.0)
        //poster?.autoPinEdge(.right, to: .right, of: self, withOffset: 5.0)
        poster?.autoSetDimension(.height, toSize: imageHeight)
        poster?.autoSetDimension(.width, toSize: (imageHeight * scaleFactor))
        //poster?.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -5.0)
        
        title?.autoPinEdge(.top, to: .top, of: self, withOffset: 5.0)
        title?.autoPinEdge(.left, to: .left, of: self, withOffset: 85.0)
        title?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        title?.autoSetDimension(.height, toSize: 35.0)
       // title?.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -5.0)
        
        language?.autoPinEdge(.top, to: .bottom, of: title!, withOffset: 5.0)
        language?.autoPinEdge(.left, to: .left, of: self, withOffset: 85.0)
        language?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        //language?.autoSetDimension(.height, toSize: 35.0)
        //language?.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -5.0)
        
        status?.autoPinEdge(.top, to: .bottom, of: language!, withOffset: 5.0)
        status?.autoPinEdge(.left, to: .left, of: self, withOffset: 85.0)
        status?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        //status?.autoSetDimension(.height, toSize: 35.0)
        
        type?.autoPinEdge(.top, to: .bottom, of: status!, withOffset: 5.0)
        type?.autoPinEdge(.left, to: .left, of: self, withOffset: 85.0)
        type?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        //type?.autoSetDimension(.height, toSize: 15.0)
        
        
    }

}
