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
}


struct Recommend: Decodable {
    let results: [Detail]
}

struct Aggregate: Decodable {
    let cast: [Detail]
}

// -> 
struct Cast: Decodable {
    let profile_path : String?
    let original_name : String
    let overview: String?
}
