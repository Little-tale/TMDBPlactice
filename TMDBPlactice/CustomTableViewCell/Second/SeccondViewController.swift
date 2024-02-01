//
//  SeccondViewController.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

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
            print(self.allDatasDic.count,"ASdsad")
            self.trendMainView.tableContentView.reloadData()
        }
        
    }
    
    func delegateAndDataSource(){
        
        trendMainView.tableContentView.delegate = self
        trendMainView.tableContentView.dataSource = self
        
        trendMainView.tableContentView.register(SeccondTableViewCell.self, forCellReuseIdentifier: SeccondTableViewCell.reuseableIdentifier)
        
        trendMainView.tableContentView.estimatedRowHeight = 200
        trendMainView.tableContentView.rowHeight = UITableView.automaticDimension
        trendMainView.tableContentView.backgroundColor = .lightGray
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
        cell.collecionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.reuseIdenti)
        
        print("테이블 뷰의 로우가 내 아들의 섹션 : ",indexPath.row)
        // -> 테이블뷰의 로우가 컬의 섹션이 될수 있겠다.
        
        //MARK: 자식컬렉션에 태그를 넣어 근데 이 태그가 유동적으로 처리하게끔 한번 해보고싶다.
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
        //print("데이터가 없니??", allData[collectionView.tag].results.count)
        return allDatasDic[collectionView.tag]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseIdenti , for: indexPath) as! SecondCollectionViewCell
        cell.backgroundColor = .brown
        
        let tag = collectionView.tag
        print("난 아들인데 번호가..? ",collectionView.tag)
        
        var url = TMDBManager.image
        
        if let urlString = allDatasDic[tag]?[indexPath.row].poster_path {
            url += urlString
        }
        if let urlString = allDatasDic[tag]?[indexPath.row].profile_path {
            url += urlString
        }
        let urlSetting = URL(string:url)
        
        cell.imageView.kf.setImage(with: urlSetting , placeholder: UIImage(systemName: "star"))
        
        cell.titleLabel.text = allDatasDic[tag]?[indexPath.row].original_name
        
        
        return cell
    }
}
// MARK: - 순서가 컬렉션 뷰의 갯수가 정해진후 값이 들어온다 그래서... 테이블 뷰가 리로드 해주어야 할것같다.
