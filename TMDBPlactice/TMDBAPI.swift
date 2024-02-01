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
    case trendTV(language:Language?, trendType: TrendType)
    case topTV(language:Language?)
    case popularTV(language:Language?)
    
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
     
        case .trendTV(_, trendType: let trendType):
            let url = URL(string: "\(baseURL)trending/tv/\(trendType)")
            return url!
            
        case .topTV(language: _):
            let url = URL(string: "\(baseURL)tv/top_rated")
            return url!
            
        case .popularTV(language: _):
            let url = URL(string: "\(baseURL)tv/popular")
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
        case .trendTV(language: let language, trendType: _):
            
            return ["language":"\(language?.get ?? "")"]
        case .topTV(language: let language):
            // ["language":"\(language?.get ?? "")"]
            return ["language":"\(language?.get ?? "")"]
            
        case .popularTV(language: let language):
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
        case .trendTV(_, _):
            return .get
        case .topTV(_):
            return .get
        case .popularTV(_):
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
    
    enum TrendType {
        case day
        case eng
        
        var get: String {
            switch self {
            case .day:
                "/day"
            case .eng:
                "/week"
            }
        }
        
        
    }
    
}



