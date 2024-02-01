import UIKit
import SnapKit
import Kingfisher
/*
 // lazy var colView = UICollectionView(frame: .zero, collectionViewLayout: layout())
 
 
 // 이게 고정적인 느낌이 있는데 차라리 정해진 갯수가 없고 그 값에 따라
 // 유동적으로 섹션이 생기면 좋지 않을까?
 */

class SeccondViewController: UIViewController {
    // 1. 테이블뷰 추가
    // let tableContentView = UITableView()
    
    let trendMainView = TrendView()

    var allDatasDic: [ Int : [Detail] ] = [:]
    
    override func loadView() {
        self.view = trendMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateAndDataSource()
    
        let group = DispatchGroup()
        
        group.enter()
        TMDBManager.shared.fetchInfoViewList(api: .trendTV(language: .kor, trendType: .day)) { results in
            self.allDatasDic[0] = results
            print("😡")
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchInfoViewList(api: .topTV(language: .kor)) { results in
            self.allDatasDic[1] = results
            print("🆑")
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchInfoViewList(api: .popularTV(language: .kor)) { results in
            self.allDatasDic[2] = results
            print("🎭")
            group.leave()
        }
       
        group.notify(queue: .main) {
            self.trendMainView.tableContentView.reloadData()
        }
        
    }
    func delegateAndDataSource(){
        
        trendMainView.tableContentView.delegate = self
        trendMainView.tableContentView.dataSource = self
    }
    

}

//MARK: - 테이블뷰가 사실상 Section -> 3개가 나오면 된다.
extension SeccondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allDatasDic.count)
        return allDatasDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeccondTableViewCell.reuseableIdentifier, for: indexPath) as! SeccondTableViewCell
        
        cell.collecionView.delegate = self
        cell.collecionView.dataSource = self
        
        cell.collecionView.tag = indexPath.row
        
        
        if let tagName = TMDBManager.TMDBTag.from(tagNum: indexPath.row) {
            cell.titleLabel.text = tagName.getTMDBTagString()
        }
        
        cell.collecionView.reloadData()
        
        return cell
    }
    
    
}
//MARK: - 컬렉션뷰는 items에 속한다고 생각
extension SeccondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return allDatasDic[collectionView.tag]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseIdenti , for: indexPath) as! SecondCollectionViewCell
        cell.backgroundColor = .brown
        
        let tag = collectionView.tag
        
        var url = TMDBManager.image
        
        if let urlString = allDatasDic[tag]?[indexPath.row].poster_path {
            url += urlString
        }
        if let urlString = allDatasDic[tag]?[indexPath.row].profile_path {
            url += urlString
        }
        let urlSetting = URL(string:url)
        
        cell.prepare(imageUrl: urlSetting, labelText: allDatasDic[tag]?[indexPath.row].original_name)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ViewController()
        vc.id = allDatasDic[collectionView.tag]?[indexPath.row].id ?? 0
        present(vc, animated: true)
    }
    
}



// MARK: - 순서가 컬렉션 뷰의 갯수가 정해진후 값이 들어온다 그래서... 테이블 뷰가 리로드 해주어야 할것같다.
