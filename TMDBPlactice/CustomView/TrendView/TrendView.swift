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
   
    
    
    
    override func configureView() {
        self.backgroundColor = .white
        
        //tableContentView.backgroundColor = .green
        
    }
    override func configureHierachy() {
       addSubview(tableContentView)
    }
    
    override func configureLayout() {
        tableContentView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
}
