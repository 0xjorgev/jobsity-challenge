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
    
    func episodeListByShow(id:Int?, completion: @escaping ([ShowResult]?, Error?) -> Void ){
        
        // set up URLRequest with URL
        let endpoint = "\(BASEURL)seasons/\(id ?? 0)/episodes"
        
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
    
    func peopleSearch(query:String?, completion: @escaping ([People]?, Error?) -> Void ){
        
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
                let people = try decoder.decode([People].self, from: responseData)
                completion(people, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completion(nil, error)
            }
            
        })
        
        task.resume()
        
    }
    
    
}
