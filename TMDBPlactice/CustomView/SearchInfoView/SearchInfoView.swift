//
//  TrendVIew.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit
import SnapKit
class SearchInfoView: BasicView {
    let tvSeriesTableView = UITableView()
    
    override func configureHierachy() {
        addSubview(tvSeriesTableView)
    }
    override func configureLayout() {
        tvSeriesTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
    }
    
}
