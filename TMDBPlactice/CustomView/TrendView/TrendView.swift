//
//  TrendView.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit
import SnapKit

class TrendView: BasicView {
    let tableContentView = UITableView()
   
   
    override func configureHierachy() {
       addSubview(tableContentView)
    }
    
    override func configureLayout() {
        tableContentView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
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
