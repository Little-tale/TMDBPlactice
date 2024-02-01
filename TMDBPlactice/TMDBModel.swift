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
    let id: Int
}

struct Details: Decodable {
    let results, cast : [Detail]?
    
}


// ------------------------

struct TMDBTVAll: Decodable {
    let results : [Detail]
}


struct AllResults: Decodable {
    let original_name: String
    let poster_path: String?
    let id: Int
}
