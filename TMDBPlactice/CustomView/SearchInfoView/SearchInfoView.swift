

// 이제 컬렉션뷰 옮기기

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
        registers()
    }
    
    
    func registers() {
        tvSeriesTableView.register(TVSeriesTableViewCell.self, forCellReuseIdentifier: TVSeriesTableViewCell.reusableIdentifier)
        tvSeriesTableView.register(TVDetailTableViewCell.self, forCellReuseIdentifier: TVDetailTableViewCell.reusableIdentifier)
        
        tvSeriesTableView.estimatedRowHeight = 250
    }
}
