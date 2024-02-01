//
//  TrendView.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit
import SnapKit

class TrendView: BasicView {
    let searchBar = UISearchBar()
    let tableContentView = UITableView()
    
    override func configureHierachy() {
        addSubview(searchBar)
        addSubview(tableContentView)
        
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide).inset(4)
            make.height.equalTo(32)
        }
        
        tableContentView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        self.backgroundColor = .white
        desingTableView()
        
    }
    
    
    func desingTableView(){
        tableContentView.register(SeccondTableViewCell.self, forCellReuseIdentifier: SeccondTableViewCell.reuseableIdentifier)
        
        tableContentView.estimatedRowHeight = 200
        tableContentView.rowHeight = UITableView.automaticDimension
    }
    
    
}
