/*
 테이블 셀에서 필요한것
 Label
 collectionView
 Cell 은 뷰컨에서 처리할것으로 보암
 */

import UIKit
import SnapKit

class TVSeriesTableViewCell: BasicTableViewCell {
    
    static let reusableIdentifier = "TVSeriesTableViewCell"
    
    let infoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    } ()
    
    
    // collecionViewLayout() 생성되기전 참조 시도는 Fail lazy로 viewdid 이후로 미룸
    lazy var tvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collecionViewLayout())

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func configureHierarchy() {
        contentView.addSubview(infoLabel)
        contentView.addSubview(tvCollectionView)
    }
    override func configureLayout() {
        infoLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView).inset(8)
            make.height.equalTo(24)
        }
        tvCollectionView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.greaterThanOrEqualTo(150).priority(900)

        }
    
    }

    func collecionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4 , height: (UIScreen.main.bounds.width / 4) * 1.5 )
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    override func designView() {
        registers()
    }
    
    func registers(){
        tvCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.reuseIdenti)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare(title: nil)
    }
    func prepare(title: String?){
        infoLabel.text = title
    }
}
