//
//  TMDBModel.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 1/31/24.
//

import Foundation

// 이제 이게 하나의 데이터 모델임
// 이건 계속해서 생성되니 연산 프로퍼티로 한번 거시기 해보자
struct Detail: Decodable {
    let original_name: String
    let poster_path: String?
    let overview: String?
    let profile_path : String?
    let first_air_date : String?
    let id: Int
    
    var getPosterURL : URL? {
        guard let posterPath = poster_path else {
            return nil
        }
        return URL(string: TMDBManager.shared.imageBase + posterPath)
    }
    
    var getProfileURL : URL? {
        guard let profile_path = profile_path else {
            return nil
        }
        return URL(string: TMDBManager.shared.imageBase + profile_path)
    }
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
