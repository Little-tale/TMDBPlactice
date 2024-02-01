//
//  TMDBModel.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 1/31/24.
//

import Foundation

// 이제 이게 하나의 데이터 모델임
struct Detail: Decodable {
    let original_name: String
    let poster_path: String?
    let overview: String?
    let profile_path : String?
    let first_air_date : String?
}

struct Details: Decodable {
    let results, cast : [Detail]?
    
}
struct DetailCast: Decodable {
    let cast:[Detail]
}

struct Recommend: Decodable {
    let results: [Detail]
}
//
struct Aggregate: Decodable {
    let cast: [Detail]
}

// ------------------------

struct TMDBTV :Decodable {
    let results : [Results]
}

struct Results: Decodable {
    let name: String
    let poster_path: String
}
///

struct TMDBTop : Decodable {
    
    let results : [TopResults]
}
struct TopResults: Decodable {
    
    let original_name: String
    let poster_path: String
}

///
struct TMDBPopular: Decodable {
    let results : [Populars]
    
}

struct Populars: Decodable {
    let original_name : String
    let poster_path : String?
}

struct TMDBTVAll: Decodable {
    let results : [AllResults]
}

struct AllResults: Decodable {
    let original_name: String
    let poster_path: String?
    let id: Int
}
