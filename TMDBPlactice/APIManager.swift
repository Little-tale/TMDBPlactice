
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
    
    static let baseUrl = "https://api.themoviedb.org/3/tv/"
    
    static let dummyId = "66573"
    static let kor = "?language=ko-KR"
    
    static let image = "https://image.tmdb.org/t/p/w500/"
    
    private init() {}
    
    static let Header: HTTPHeaders = [
        "Authorization" : APIKey.tmdb
    ]
    
    // 1. 통신 성공
    // 2. 값을 어떤 형태로 전달할지 고민해야함 차피 하나여서
    
    func fetchDetail(id: String, complitionHandller: @escaping(Detail) -> Void ) {
        //https://api.themoviedb.org/3/tv/{series_id}?language=ko-KR
        
        let url = TMDBManager.baseUrl + id + TMDBManager.kor
        
        AF.request(url, method: .get, headers: TMDBManager.Header).responseDecodable(of: Detail.self) { response in
            switch response.result {
            case .success(let success):
                complitionHandller(success)
            case .failure(let failure):
                
                print(failure)
            }
        }
    }
    func fetchRecommend(id: String, complitionHandller: @escaping ([Detail]) -> Void) {
        // https://api.themoviedb.org/3/tv/{series_id}/recommendations
        
        let url = TMDBManager.baseUrl + id + "/recommendations"
        
        AF.request(url, method: .get, headers: TMDBManager.Header).responseDecodable(of: Recommend.self) { response in
            switch response.result {
            case .success(let success):
                complitionHandller(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // 없는 값을 nil 로 해서 하나의 데이터 모델로 만들수 있다...!
    // 
    func fetchAggregate(id: String, complitionHandller:  @escaping ([Detail]) -> Void ) {
        // https://api.themoviedb.org/3/tv/{series_id}/aggregate_credits
        let url = TMDBManager.baseUrl + id + "/aggregate_credits"
        
        AF.request(url, method: .get, headers: TMDBManager.Header).responseDecodable(of: Aggregate.self) { response in
            switch response.result {
            case .success(let success):
                complitionHandller(success.cast)
            case .failure(let failure):
                print(failure,"🎭🎭🎭🎭🎭🎭🎭🎭🎭🎭")
            }
        }
    }
    
    
}
