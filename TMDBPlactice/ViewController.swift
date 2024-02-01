/*
 현재 필요한 것은
 
 테이블 뷰 V -> 수정사항 테이블 뷰안에 테이블뷰와 컬렉션 뷰를 먹어야 할것 같은데
 테이블 뷰 셀 V
 셀안의 컬렉션뷰 V
 셀안의 컬렉션뷰 셀 V
 
 -- 너무 오래 걸림 좀더 자세히 정보를 보고 레이아웃 생각해야함
 -> 중간에 잘못 판단한거 너무큼
 
 */

/*
 이제 고민해 보아야 할 문제는
 0. 지금 딕셔너리가 하드하게 0, 1, 2 로 눈에 보이게 해놓고 있는데 이 부분을 다른 방법이 있다면 좋을것 같다.
 -> 일단 각 테이블 Row 에 해당하는 레이블이 어떤 레이블인지  Enum화 할 필요성이 보인다.
 
 1. 각 테이블뷰의 infoLabel에 어떠한 정보를 넘겨 줄수 있을까를 고민해 보아야 한다.
 2. 검색 할때에 id값을 받아오고 그 id 값을 통해 다시한면 요청할수 있으면 좋을것 같다.
 
 */

/*
 URL 부분 메서드 만들어서 코드 간결화 해야 좋을듯 해
 */

import UIKit
import SnapKit
import Kingfisher

class ViewController: BasicViewController {
    
    let mainView = SearchInfoView()
    
    var allDatasDic: [ Int : [Detail] ] = [:]
    
    var id: Int = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerInView()
        let group = DispatchGroup()
        
        // id = 93405
        // MARK: - append를 했었는데 이게 끝나는게 사실 제 각각 인셈이라 좋은 방법이 아닌것 같음
        group.enter()
        TMDBManager.shared.fetchInfoView(api: .detail(id: id, language: .kor)) {
            results in
            self.allDatasDic[0] = results
            group.leave()
        }
        group.enter()
        TMDBManager.shared.fetchInfoViewList(api: .recommend(id: id, language: .kor)) {
            results in
            self.allDatasDic[1] = results
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchInfoViewList(api: .Aggregate(id: id, language: .kor)) {
            results in
            self.allDatasDic[2] = results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tvSeriesTableView.reloadData()
        }
        
    }
    
    // TVSeriesTableViewCell
    // TVDetailTableViewCell
    func registerInView() {
        mainView.tvSeriesTableView.delegate = self
        mainView.tvSeriesTableView.dataSource = self
        
        // 레지스터 있던 자리
    }
    
}

//MARK: - 코드가 더 간결해 질수 없을까..?
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDatasDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tagName = TMDBManager.TVSearchResultsSections.from(tagNum: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TVSeriesTableViewCell.reusableIdentifier, for: indexPath) as! TVSeriesTableViewCell
        
        if indexPath.row == TMDBManager.TVSearchResultsSections.results.rawValue {
            let resultcell = tableView.dequeueReusableCell(withIdentifier: TVDetailTableViewCell.reusableIdentifier, for: indexPath) as! TVDetailTableViewCell
            //
            let index = TMDBManager.TVSearchResultsSections.results.rawValue
            let item = allDatasDic[indexPath.row]?[index]
            
            resultcell.prepare(name: item?.original_name, image: item?.getPosterURL, overView: item?.overview, firstDate: item?.first_air_date)
            
            return resultcell
            
        } else {
            cell.tvCollectionView.dataSource = self
            cell.tvCollectionView.delegate = self
            
            cell.prepare(title: tagName.discription)
            // 레지스터 있던자리
            cell.tvCollectionView.tag = indexPath.row
            
            cell.tvCollectionView.reloadData()
            print("🔥🔥🔥🔥🔥🔥🔥")
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return allDatasDic[collectionView.tag]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseIdenti, for: indexPath) as! SecondCollectionViewCell
        
        let tag = collectionView.tag
        let item = allDatasDic[tag]?[indexPath.item]
        
        if let posterUrl = item?.getPosterURL {
            cell.prepare(imageUrl: posterUrl, labelText: item?.original_name)
        }
        
        if let profileUrl = item?.getProfileURL {
            cell.prepare(imageUrl: profileUrl, labelText: item?.original_name)
        }
        
        return cell
    }
    
}

