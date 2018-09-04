//
//  ShowDetailHeaderView.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/2/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class ShowDetailHeaderView:UIView {
    
    var poster:UIImageView?
    
    var title:UILabel?
    
    var mainCategory:UILabel?
    
    var secondCategory:UILabel?
    
    var thirdCategory:UILabel?
    
    var fourthCategory:UILabel?
    
    var language:UILabel?
    
    var scheduleDay:UILabel?
    
    var scheduleTime:UILabel?
    
    var network:UILabel?
    
    var genresStack:UIStackView?
    
    var genresStack2:UIStackView?
    
    
    struct HeaderData { let show:Show? }
    
    var headerData:HeaderData? {
        
        didSet{
            
            title?.text = "\(headerData?.show?.name ?? "") (\(headerData?.show?.rating?.average ?? 0))"
            
            language?.text = "\(headerData?.show?.language ?? "") / \(headerData?.show?.status ?? "")"
            
            scheduleTime?.text = "\(headerData?.show?.schedule?.time ?? "") / \(headerData?.show?.runtime ?? 0) Mins."
            
            scheduleDay?.text = headerData?.show?.schedule?.days?.reduce("", { x,y in x + " " + y })
            
            network?.text = "Network: \(headerData?.show?.network?.name ?? "") - \(headerData?.show?.network?.country?.code ?? "") "
            
            poster?.image = UIImage(named: "empty-image")
            
            poster?.moa.onSuccess = { image in
                return image
            }
            
            poster?.moa.url = headerData?.show?.image?.medium
            
            if !(headerData?.show?.genres?.isEmpty ?? true) {
                
                for idx in 0 ... ((headerData?.show?.genres?.count)!  - 1) {
                    
                    switch idx {
                    case 0:
                        mainCategory?.text = " \(headerData?.show?.genres?[0] ?? "") "
                        mainCategory?.backgroundColor = self.colorForGenres(name: (headerData?.show?.genres?[0])!)
                        break
                    case 1:
                        secondCategory?.text = " \(headerData?.show?.genres?[1] ?? "") "
                        secondCategory?.backgroundColor = self.colorForGenres(name: (headerData?.show?.genres?[1])!)
                        break
                    case 2:
                        thirdCategory?.text = " \(headerData?.show?.genres?[2] ?? "") "
                        thirdCategory?.backgroundColor = self.colorForGenres(name: (headerData?.show?.genres?[2])!)
                        break
                    case 3:
                        fourthCategory?.text = " \(headerData?.show?.genres?[3] ?? "") "
                        fourthCategory?.backgroundColor = self.colorForGenres(name: (headerData?.show?.genres?[3])!)
                        break
                    default:break
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(){
        
        poster = UIImageView()
        
        poster?.contentMode = .scaleAspectFit
        
        self.addSubview(poster!)
        
        
        title = UILabel()
        
        title?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        title?.textColor = Colors.black
        
        title?.numberOfLines = 2
        
        self.addSubview(title!)
        
        
        mainCategory = UILabel()
        
        mainCategory?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        mainCategory?.textColor = Colors.white
        
        mainCategory?.textAlignment = .center
        
        mainCategory?.addRoundedCorners()
        
        //self.addSubview(mainCategory!)
        
        secondCategory = UILabel()
        
        secondCategory?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        secondCategory?.textColor = Colors.white
        
        secondCategory?.textAlignment = .center
        
        secondCategory?.addRoundedCorners()
        
        
        
        thirdCategory = UILabel()
        
        thirdCategory?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        thirdCategory?.textColor = Colors.white
        
        thirdCategory?.textAlignment = .center
        
        thirdCategory?.addRoundedCorners()
        
        
        
        fourthCategory = UILabel()
        
        fourthCategory?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        fourthCategory?.textColor = Colors.white
        
        fourthCategory?.textAlignment = .center
        
        fourthCategory?.addRoundedCorners()
        
        
        
        genresStack = UIStackView()
        
        genresStack?.alignment = .center
        
        genresStack?.axis = .horizontal
        
        genresStack?.distribution = .fillEqually
        
        genresStack?.addArrangedSubview(mainCategory!)
        
        genresStack?.addArrangedSubview(secondCategory!)
        
        genresStack?.spacing = 5.0
        
        self.addSubview(genresStack!)
        
        
        genresStack2 = UIStackView()
        
        genresStack2?.alignment = .center
        
        genresStack2?.axis = .horizontal
        
        genresStack2?.distribution = .fillEqually
        
        genresStack2?.addArrangedSubview(thirdCategory!)
        
        genresStack2?.addArrangedSubview(fourthCategory!)
        
        genresStack2?.spacing = 5.0
        
        self.addSubview(genresStack2!)

        
        language = UILabel()
        
        language?.font = UIFont.systemFont(ofSize: 14.0)
        
        language?.textColor = Colors.black
        
        self.addSubview(language!)
        
        
        scheduleTime = UILabel()
        
        scheduleTime?.font = UIFont.systemFont(ofSize: 14.0)
        
        scheduleTime?.textColor = Colors.black
        
        self.addSubview(scheduleTime!)
        
        
        scheduleDay = UILabel()
        
        scheduleDay?.font = UIFont.systemFont(ofSize: 14.0)
        
        scheduleDay?.textColor = Colors.gray
        
        scheduleDay?.numberOfLines = 2
        
        self.addSubview(scheduleDay!)
        
        
        
        network = UILabel()
        
        network?.font = UIFont.systemFont(ofSize: 14.0)
        
        network?.textColor = Colors.gray
        
        network?.numberOfLines = 3
        
        network?.textAlignment = .center
        
        self.addSubview(network!)
        
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        let imageHeight:CGFloat = CGFloat(180.0)
        let scaleFactor:CGFloat = CGFloat(0.7118)
        
        poster?.autoPinEdge(.top, to: .top, of: self, withOffset: 5.0)
        poster?.autoPinEdge(.left, to: .left, of: self, withOffset: 5.0)
        poster?.autoSetDimension(.height, toSize: imageHeight)
        poster?.autoSetDimension(.width, toSize: (imageHeight * scaleFactor))
        
        title?.autoPinEdge(.top, to: .top, of: self, withOffset: 5.0)
        title?.autoPinEdge(.left, to: .left, of: self, withOffset: 135.0)
        title?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        //title?.autoSetDimension(.height, toSize: 65.0)
        
        language?.autoPinEdge(.top, to: .bottom, of: title!, withOffset: 5.0)
        language?.autoPinEdge(.left, to: .left, of: self, withOffset: 135.0)
        language?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        genresStack?.autoPinEdge(.top, to: .bottom, of: language!, withOffset: 5.0)
        genresStack?.autoPinEdge(.left, to: .left, of: self, withOffset: 135.0)
        genresStack?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        genresStack2?.autoPinEdge(.top, to: .bottom, of: genresStack!, withOffset: 5.0)
        genresStack2?.autoPinEdge(.left, to: .left, of: self, withOffset: 135.0)
        genresStack2?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        scheduleTime?.autoPinEdge(.top, to: .bottom, of: genresStack2!, withOffset: 5.0)
        scheduleTime?.autoPinEdge(.left, to: .left, of: self, withOffset: 135.0)
        scheduleTime?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        scheduleDay?.autoPinEdge(.top, to: .bottom, of: scheduleTime!, withOffset: 5.0)
        scheduleDay?.autoPinEdge(.left, to: .left, of: self, withOffset: 134.0)
        scheduleDay?.autoPinEdge(.right, to: .right, of: self, withOffset: -5.0)
        
        network?.autoPinEdge(.top, to: .bottom, of: poster!, withOffset: 5.0)
        network?.autoPinEdge(.left, to: .left, of: self, withOffset: 5.0)
        network?.autoSetDimension(.width, toSize: 128.0)
//        network?.autoPinEdge(.right, to: .right, of: self, withOffset: -300.0)
        
        
        
    }
    
    
    func colorForGenres(name:String) -> UIColor {
        
        switch name {
            case "Comedy": return UIColor(red:0.00, green:1.00, blue:0.52, alpha:1.0)
            case "Drama": return UIColor(red:0.10, green:0.20, blue:0.44, alpha:1.0)
            case "Family": return UIColor(red:0.95, green:0.46, blue:0.19, alpha:1.0)
            case "Romance": return UIColor(red:0.95, green:0.19, blue:0.74, alpha:1.0)
            case "Food": return UIColor(red:0.25, green:0.23, blue:0.93, alpha:1.0)
            case "Crime": return UIColor(red:0.21, green:0.21, blue:0.24, alpha:1.0)
            case "History": return UIColor(red:0.17, green:0.72, blue:0.90, alpha:1.0)
            case "Fantasy": return UIColor(red:0.97, green:0.88, blue:0.08, alpha:1.0)
            case "Medical": return UIColor(red:0.68, green:0.67, blue:0.62, alpha:1.0)
            case "Mystery": return UIColor(red:0.80, green:0.30, blue:0.92, alpha:1.0)
            case "Adventure": return UIColor(red:0.22, green:0.66, blue:0.99, alpha:1.0)
            case "Action": return UIColor(red:0.05, green:0.37, blue:0.61, alpha:1.0)
            case "War": return UIColor(red:0.21, green:0.51, blue:0.11, alpha:1.0)
            case "Anime": return UIColor(red:0.47, green:0.71, blue:0.93, alpha:1.0)
            case "Horror": return UIColor(red:0.35, green:0.38, blue:0.42, alpha:1.0)
            case "Thriller": return UIColor(red:0.67, green:0.25, blue:0.44, alpha:1.0)
            case "Children": return UIColor(red:0.47, green:0.06, blue:0.57, alpha:1.0)
            case "Supernatural": return UIColor(red:0.66, green:0.73, blue:0.69, alpha:1.0)
            case "Science-Fiction": return UIColor(red:0.61, green:0.87, blue:0.52, alpha:1.0)
            default: return .black
        }
    }
    
    
}
