//
//  ShowDTO.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import RealmSwift

class ShowDTO: Object {
    
    @objc dynamic var showId:Int = 0
    
    @objc dynamic var objectID = UUID().uuidString
    
    override static func primaryKey() -> String? {
        
        return "objectID"
    }
    
}
