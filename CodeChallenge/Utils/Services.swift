//
//  Services.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 8/31/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

//Enable non-https content
let BASEURL = "http://api.tvmaze.com/"

class Services:NSObject {
    
    //Singleton pattern
    static let shared = Services()
    
    let session = URLSession.shared
    
    func retriveShowList(page:Int?, completion: @escaping ([Show]?, Error?) -> Void ){
        
        // set up URLRequest with URL
        let endpoint = "\(BASEURL)shows?page=\(page ?? 1)"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, error)
                return
            }
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let show = try decoder.decode([Show].self, from: responseData)
                completion(show, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
            
        })
        
        task.resume()
        
    }
    
    func searchShowByName(query:String?, completion: @escaping ([ShowResult]?, Error?) -> Void ){
        
        // set up URLRequest with URL
        let endpoint = "\(BASEURL)search/shows?q=\(query ?? "")"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, error)
                return
            }
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let show = try decoder.decode([ShowResult].self, from: responseData)
                completion(show, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
            
        })
        
        task.resume()
        
    }
    
    func episodeListBySeason(seasonId:Int?, completion: @escaping ([Episode]?, Error?) -> Void ){
        
        // set up URLRequest with URL
        let endpoint = "\(BASEURL)seasons/\(seasonId ?? 0)/episodes"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, error)
                return
            }
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                var list = try decoder.decode([Episode].self, from: responseData)
                
                
                //call child service to parse episodes for this array
                
                
                
                completion(list, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
            
        })
        
        task.resume()
        
    }
    
    
    func seasonsByShow(showId:Int?, completion: @escaping ([Season]?, Error?) -> Void ){
        
        // set up URLRequest with URL
        let endpoint = "\(BASEURL)shows/\(showId ?? 0)/seasons"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, error)
                return
            }
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let list = try decoder.decode([Season].self, from: responseData)
                
                completion(list, nil)
                
                
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
            
        })
        
        task.resume()
        
    }
    
    func peopleSearch(query:String?, completion: @escaping ([PersonResult]?, Error?) -> Void ){
        
        // set up URLRequest with URL
        let endpoint = "\(BASEURL)search/people?q=\(query ?? "")"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, error)
                return
            }
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([PersonResult].self, from: responseData)
                completion(result, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
            
        })
        
        task.resume()
        
    }
    
    
}
