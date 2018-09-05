//
//  PeopleTableViewCell.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

class PeopleTableViewCell:ShowTableViewCell{
    
    struct PeopleData {
        let person:Person?
    }
    
    var peopleData:PeopleData? {
        didSet{
            
            title?.text = peopleData?.person?.name ?? ""
            
            language?.text = "\(peopleData?.person?.birthday ?? "") (\(peopleData?.person?.country?.code ?? "" ))"
            
            status?.text = "\(peopleData?.person?.gender ?? "")"
            
            type?.text = ""
            
            poster?.image = UIImage(named: "empty-image")
            
            poster?.moa.onSuccess = { image in
                return image
            }
            
            poster?.moa.url = peopleData?.person?.image?.medium
            
            print("Id: \(peopleData?.person?.id)")
        }
    }
}
