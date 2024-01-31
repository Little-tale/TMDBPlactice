/*
 현재 필요한 것은
 
 테이블 뷰 V -> 수정사항 테이블 뷰안에 테이블뷰와 컬렉션 뷰를 먹어야 할것 같은데
 테이블 뷰 셀 V
 셀안의 컬렉션뷰 V
 셀안의 컬렉션뷰 셀 V
 
 -- 너무 오래 걸림 좀더 자세히 정보를 보고 레이아웃 생각해야함
 -> 중간에 잘못 판단한거 너무큼
 
 
 
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
            
            // print(self.accessDatas.first)
            
            print("11111")
            group.leave()
        }
       
        group.enter()
        TMDBManager.shared.fetchRecommend(id: TMDBManager.dummyId) { results in
            self.secondDatas.append(contentsOf: results)
            self.allDatas.append(results)
            
            self.allDatasDic[1] = results
            
            print("22222")
            group.leave()
        }
        group.enter()
        TMDBManager.shared.fetchAggregate(id: TMDBManager.dummyId) { results in
            self.thirdDatas.append(contentsOf:results)
            self.allDatas.append(results)
            
            self.allDatasDic[2] = results
            
            print("33333")
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVDetailTableViewCell.reusableIdentifier, for: indexPath) as! TVDetailTableViewCell
            
            cell.originalNameLabel.text = accessDatas[indexPath.row].original_name
            let urlString = TMDBManager.image + (accessDatas[indexPath.row].poster_path ?? "")
            
            let url = URL(string: urlString)
            
            cell.posterImageView.kf.setImage(with: url)
            cell.overViewLabel.text = accessDatas[indexPath.row].overview
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVSeriesTableViewCell.reusableIdentifier, for: indexPath) as! TVSeriesTableViewCell
            cell.infoLabel.text = "비슷한 임시 이름"
            cell.tvCollectionView.dataSource = self
            cell.tvCollectionView.delegate = self
            
            cell.tvCollectionView.tag = indexPath.row
            
            cell.tvCollectionView.register(TVDetailCollectionViewCell.self, forCellWithReuseIdentifier: TVDetailCollectionViewCell.reusuableIdentifier)
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVSeriesTableViewCell.reusableIdentifier, for: indexPath) as! TVSeriesTableViewCell
            cell.infoLabel.text = "비슷한 임시 이름2"
            cell.tvCollectionView.dataSource = self
            cell.tvCollectionView.delegate = self
            
            cell.tvCollectionView.tag = indexPath.row
            
            cell.tvCollectionView.register(TVDetailCollectionViewCell.self, forCellWithReuseIdentifier: TVDetailCollectionViewCell.reusuableIdentifier)
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.tag)
        return allDatas[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVDetailCollectionViewCell.reusuableIdentifier, for: indexPath) as! TVDetailCollectionViewCell
        
        print("내가 컬렉션뷰 태그야 !!! ",collectionView.tag)
        
        let tag = collectionView.tag
        print("내가 컬렉션뷰 태그 마이너스 버전!!! ", collectionView.tag - 1)
        
        //let urlString = TMDBManager.image + (allDatas[tag][indexPath.row].profile_path ?? "")
        // let urlString = TMDBManager.image + (allDatasDic[tag]?[indexPath.row].profile_path ?? "")
        
        var url = TMDBManager.image
        
        if let urlString = allDatasDic[tag]?[indexPath.row].poster_path {
            url += urlString
        }
        if let urlString = allDatasDic[tag]?[indexPath.row].profile_path {
            url += urlString
        }
        
        
        print("url String", url)
        
        let urlSetting = URL(string:url)
        
        cell.posterImageView.kf.setImage(with: urlSetting, placeholder: UIImage(systemName: "star"))
        cell.originalNameLabel.text = allDatas[tag][indexPath.row].original_name

        
        return cell
    }

    
    
}

//#Preview {
//    ViewController()
//}
