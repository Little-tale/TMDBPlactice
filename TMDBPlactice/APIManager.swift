
/*
 드라마 정보 : 티비 디테일
 https://api.themoviedb.org/3/tv/{series_id}?language=ko-KR 
            -> 시리즈 아이디는 https://api.themoviedb.org/3/search/tv 쿼리스트링(검색어) 를통해 ID로 파악
            -> 더미 아이디 : 66573
 비슷한 드라마 추천 : https://api.themoviedb.org/3/tv/{series_id}/recommendations
 
 드라마 캐스트 정보 : https://api.themoviedb.org/3/tv/{series_id}/aggregate_credits
    
 
 1. 통신하기전 모델링 준비 하기전 겹치는 부분 확인
 2. 모델을 통해 통신 테스트
 3. 통신을 통해 값 받기 테스트
 4. 뷰에 뿌려주기 테스트
 */

import UIKit
import Alamofire

class TMDBManager {
    
    static let shared = TMDBManager()
    static let dummyId = "64010"
    
    var imageBase : String {
        return "https://image.tmdb.org/t/p/w500/"
    }
    
    
    /// NEW
    func fetchInfoView(api: TMDBAPITV, complitionHandller: @escaping([Detail]) -> Void) {
        
        print(api.endPoint)
   
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.Header).responseDecodable(of: Detail.self) {response in
            switch response.result {
            case .success(let success):
                // print(success)
                complitionHandller([success])
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    /// NEW2 Details
    func fetchInfoViewList(api: TMDBAPITV, complitionHandller: @escaping([Detail]) -> Void) {
        
        print(api.endPoint)
        
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.Header).responseDecodable(of: Details.self) {response in
            switch response.result {
            case .success(let success):
                if let suc = success.results {
                    // dump(suc)
                    complitionHandller(suc)
                }
                if let suc = success.cast {
                    complitionHandller(suc)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    enum TVSearchResultsSections:Int {
        case results
        case recommend
        case Aggregate
        
        var discription: String {
            switch self {
            case .results:
                "드라마 정보"
            case .recommend:
                "드라마 추천"
            case .Aggregate:
                "드라마 캐스트 정보"
            }
        }
        static func from(tagNum : Int) -> TVSearchResultsSections? {
            return TVSearchResultsSections(rawValue: tagNum)
        }
    }
    
   /// VIew 2 -> Start
    

    // MARK: - 테스트를 위해 숫자를 마구잡이로 -> 하게되면 만들어둔 배열이 0 1 2 3 이런식이라 고민 많이 해야함
    enum TMDBTag: Int {
        case trendTV
        case topRatedTV
        case popularTV
        
        // MARK: - 이메서드는 각 태그의 따라 스트링을 뱉어줄거야
        var getTMDBTagString : String {
            switch self {
            case .trendTV:
                "트렌드"
            case .topRatedTV:
                "TOP RATED"
            case .popularTV:
                "POPULAR"
            }
        }
        
        // MARK: 이 메서드는 태그 숫자를 받으면 태그를 넘겨줄거야
        static func from(tagNum: Int) -> TMDBTag? {
            return TMDBTag(rawValue: tagNum)
        }
    }
    
    private init() {}
    
    static let Header: HTTPHeaders = [
        "Authorization" : APIKey.tmdb
    ]


}
