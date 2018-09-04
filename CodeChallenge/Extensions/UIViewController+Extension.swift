//
//  UIViewController+Extension.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/2/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addImageTitle(name:String){
        
        let image = UIImageView(image: UIImage(named: name)!)
        
        image.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = image
        
    }
    
    func customLargeTitle(title:String){
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = title
    }
    
    func customSmallNavBar(){
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
    
    }
    
    func estimateSummaryHeigth(content text:String?) -> CGFloat {
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: (UIScreen.main.bounds.width - CGFloat(24)), height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let size = CGSize(width: (UIScreen.main.bounds.width - CGFloat(24)), height: CGFloat.greatestFiniteMagnitude)
        let neededSize = label.sizeThatFits(size)
        return (neededSize.height + CGFloat(68.5))
    }
}
