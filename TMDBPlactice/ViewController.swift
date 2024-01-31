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

import UIKit
import SnapKit
import Kingfisher

class ViewController: BasicViewController {
    
    let tvSeriesTableView = UITableView()
    
    let dummyTexts = ["드라마정보","비슷한 드라마 추천","드라마 캐스트 정보"]
    
    // 이걸 딕셔너리로 key값을 통해 해결해 볼수 있게 해보는것도 좋은 방법이 될것 같음
    var allDatas: [[Detail]] = []
    
    var allDatasDic: [ Int : [Detail] ] = [:]
    
    var accessDatas: [Detail] = []
    var secondDatas: [Detail] = []
    var thirdDatas: [Detail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerInView()
        let group = DispatchGroup()
        
        group.enter()
        
        // MARK: - append를 했었는데 이게 끝나는게 사실 제 각각 인셈이라 좋은 방법이 아닌것 같음
        TMDBManager.shared.fetchDetail(id: TMDBManager.dummyId) { result in
            self.accessDatas.append(result)
            self.allDatas.append([result])
        
            self.allDatasDic[0] = [result]
            
            group.leave()
        }
       
        group.enter()
        TMDBManager.shared.fetchRecommend(id: TMDBManager.dummyId) { results in
            self.secondDatas.append(contentsOf: results)
            self.allDatas.append(results)
            
            self.allDatasDic[1] = results
            
            group.leave()
        }
        group.enter()
        TMDBManager.shared.fetchAggregate(id: TMDBManager.dummyId) { results in
            self.thirdDatas.append(contentsOf:results)
            self.allDatas.append(results)
            
            self.allDatasDic[2] = results
            
            group.leave()
        }
        
        
        group.notify(queue: .main) {
            self.tvSeriesTableView.reloadData()
        }
        
    }

    override func configureHierarchy() {
        view.addSubview(tvSeriesTableView)
    }
    override func configureLayout() {
        tvSeriesTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func registerInView() {
        tvSeriesTableView.delegate = self
        tvSeriesTableView.dataSource = self
        tvSeriesTableView.estimatedRowHeight = 250
        
       
        tvSeriesTableView.register(TVSeriesTableViewCell.self, forCellReuseIdentifier: TVSeriesTableViewCell.reusableIdentifier)
        tvSeriesTableView.register(TVDetailTableViewCell.self, forCellReuseIdentifier: TVDetailTableViewCell.reusableIdentifier)
    }
    
    override func designView() {
        tvSeriesTableView.backgroundColor = .brown
    }
}

//MARK: - 코드가 더 간결해 질수 없을까..?
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tagName = TMDBManager.TVSearchResultsSections.from(tagNum: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TVSeriesTableViewCell.reusableIdentifier, for: indexPath) as! TVSeriesTableViewCell
        
        if indexPath.row == TMDBManager.TVSearchResultsSections.results.rawValue {
            let resultcell = tableView.dequeueReusableCell(withIdentifier: TVDetailTableViewCell.reusableIdentifier, for: indexPath) as! TVDetailTableViewCell
            resultcell.originalNameLabel.text = accessDatas[indexPath.row].original_name
            let urlString = TMDBManager.image + (accessDatas[indexPath.row].poster_path ?? "")
            
            let url = URL(string: urlString)
            
            resultcell.posterImageView.kf.setImage(with: url)
            resultcell.overViewLabel.text = accessDatas[indexPath.row].overview
            return resultcell
            
        } else {
            cell.tvCollectionView.dataSource = self
            cell.tvCollectionView.delegate = self
            cell.infoLabel.text = tagName.discription()
            
            cell.tvCollectionView.register(TVDetailCollectionViewCell.self, forCellWithReuseIdentifier: TVDetailCollectionViewCell.reusuableIdentifier)
            cell.tvCollectionView.tag = indexPath.row
            
            cell.tvCollectionView.reloadData()
            
            return cell
        }
        

       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // print(collectionView.tag)
        return allDatas[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVDetailCollectionViewCell.reusuableIdentifier, for: indexPath) as! TVDetailCollectionViewCell
        
        let tag = collectionView.tag
        
        var url = TMDBManager.image
        
        if let urlString = allDatasDic[tag]?[indexPath.row].poster_path {
            url += urlString
        }
        if let urlString = allDatasDic[tag]?[indexPath.row].profile_path {
            url += urlString
        }
        
        let urlSetting = URL(string:url)
        
        cell.posterImageView.kf.setImage(with: urlSetting, placeholder: UIImage(systemName: "star"))
        cell.originalNameLabel.text = allDatas[tag][indexPath.row].original_name
        
        
        return cell
    }

    
    
}

//#Preview {
//    ViewController()
//}
