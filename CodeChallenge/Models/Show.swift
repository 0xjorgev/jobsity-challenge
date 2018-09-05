//
//  Show.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 8/31/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation

struct Show:Decodable {
    
    let id:Int?
    let url:String?
    let type:String?
    let name:String?
    let language:String?
    let genres:[String]?
    let status:String?
    let runtime:Int?
    let premiered:String?
    let officialSite:String?
    let schedule:Schedule?
    let rating:Rating?
    let weight:Int?
    let network:Network?
    let webChannel:WebChannel?
    let externals:External?
    let image:Media?
    let summary:String?
    let links:Links?
    let updated:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case type
        case name
        case language
        case genres
        case status
        case runtime
        case premiered
        case officialSite
        case schedule
        case rating
        case weight
        case network
        case webChannel
        case externals
        case image
        case summary
        case links = "_links"
        case updated
    }
    
}

struct Schedule:Decodable {
    let time:String?
    let days:[String]?
}

struct Network:Decodable {
    let id:Int?
    let name:String?
    let country:Country?
    
}

struct Rating:Decodable {
    let average:Double?
}

struct Country:Decodable {
    let name:String?
    let code:String?
    let timezone:String?
}

struct WebChannel:Decodable {
    let id:Int?
    let name:String?
}

struct External:Decodable {
    let tvrage:Int?
    let thetvdb:Int?
    let imdb:String?
}

struct Media:Decodable {
    let medium:String?
    let original:String?
}

struct Links:Decodable {
    let current:Ref?
    let previous:Ref?
    
    enum CodingKeys: String, CodingKey {
        case current = "self"
        case previous = "previousepisode"
    }
}

struct Ref:Decodable{
    let href:String?
}

struct ShowResult:Decodable {
    let show:Show?
    let score:Double?
}

struct Episode:Decodable {
    
    let id:Int?
    let url:String?
    let number:Int?
    let season:Int?
    let name:String?
    let airdate:String?
    let airtime:String?
    let airstamp:String?
    let runtime:Int?
    let image:Media?
    let summary:String?
    let link:Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case number
        case season
        case name
        case airdate
        case airtime
        case airstamp
        case runtime
        case image
        case summary
        case link = "_links"
    }
}

struct Season:Decodable {
    
    let id:Int?
    let url:String?
    let number:Int?
    let name:String?
    let episodeOrder:Int?
    let premierDate:String?
    let endDate:String?
    let netWork:Network?
    let webChannel:WebChannel?
    let image:Media?
    let summary:String?
    let link:Links
    var episodes:[Episode]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case number
        case name
        case episodeOrder
        case premierDate
        case endDate
        case netWork
        case webChannel
        case image
        case summary
        case episodes
        case link = "_links"
        
    }
}

extension Season {
    init(season:Season, episodes:[Episode]){
        self.id = season.id
        self.url = season.url
        self.number = season.number
        self.name = season.name
        self.episodeOrder = season.episodeOrder
        self.premierDate = season.premierDate
        self.endDate = season.endDate
        self.netWork = season.netWork
        self.webChannel = season.webChannel
        self.image = season.image
        self.summary = season.summary
        self.link = season.link
        self.episodes = episodes
    }
}

struct Person:Decodable {
    
    let id:Int?
    let url:String?
    let name:String?
    let country:Country?
    let birthday:String?
    let deathday:String?
    let gender:String?
    let image:Media?
    let link:Links?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case url
        case name
        case country
        case birthday
        case deathday
        case gender
        case image
        case link = "_links"

    }
    
}

struct PersonResult:Decodable {
    let person:Person?
    let score:Double?
}

struct Embeded:Decodable {
    let show:Show?
    
    enum CodingKeys: String, CodingKey {
        
        case show
    }
}

struct EmbeddedShow:Decodable {
    let embeded:Embeded?
    
    enum CodingKeys: String, CodingKey {
        
        case embeded = "_embedded"
        
    }
}


