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

struct Episode {}

struct Season {}

struct People:Decodable {}


