//
//  APIManagers.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit
import Alamofire

enum TMDBAPITV {
    case detail(id: Int, language: Language?)
    case recommend(id: Int, language: Language?)
    case Aggregate(id: Int, language: Language?)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    var Header: HTTPHeaders { [
        "Authorization" : APIKey.tmdb
    ] }
    // https://api.themoviedb.org/3/  tv/  43242  /recommendations
    var endPoint: URL {
        switch self {
        case .detail(let id, _):
            let url = URL(string: "\(baseURL)tv/\(id)")
            // print(url)
            return url!
            
        case .recommend(let id, _):
            let url = URL(string: "\(baseURL)tv/\(id)/recommendations")
            return url!
            
        case .Aggregate(let id, _):
            let url = URL(string: "\(baseURL)tv/\(id)/aggregate_credits")
            return url!
        }
    }
    
    var parameter : Parameters {
        switch self {
        case .detail(_, let language):

            return ["language":"\(language?.get ?? "")"]
        case .recommend(_, let language):
            
            return ["language":"\(language?.get ?? "")"]
        case .Aggregate(_, let language):
            
            return ["language":"\(language?.get ?? "")"]
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .detail(_, _):
            return .get
        case .recommend(_, _):
            return .get
        case .Aggregate(_, _):
            return .get
        }
    }
    
    enum Language {
        case kor
        case eng
        
        var get: String {
            switch self {
            case .kor:
                "ko-KR"
            case .eng:
                "en-US"
            }
        }
    }
}



