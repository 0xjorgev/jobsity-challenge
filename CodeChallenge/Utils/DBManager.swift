//
//  DBManager.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/4/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    private var   database:Realm
    
    static let   shared = DBManager()
    
    private init() {
        
        database = try! Realm()
    }
    
    
    func getDataFromDB() ->   Results<ShowDTO> {

        let results: Results<ShowDTO> =   database.objects(ShowDTO.self)

        return results
    }
    
    func addData(object: ShowDTO)   {

        try! database.write {

            database.add(object, update: true)

            print("Added new object")
        }
    }
    
    func deleteAllFromDatabase()  {
        
        try!   database.write {
            
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: ShowDTO)   {

        try!   database.write {

            database.delete(object)
        }
        
        print("Deleted object")
    }
    
    func getObjectById(id:Int) -> ShowDTO?{
        
        let results: Results<ShowDTO> =   database.objects(ShowDTO.self).filter("showId == \(id)")
        
        return results.first
    }
    
    func DBContains(showId: Int) -> Bool {
        
        let results: Results<ShowDTO> =   database.objects(ShowDTO.self)
        
        return (results.filter{ $0.showId == showId }.count > 0)
    }
}
