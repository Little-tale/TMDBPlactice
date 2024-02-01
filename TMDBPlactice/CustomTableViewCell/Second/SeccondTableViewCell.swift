//
//  SeccondTableViewCell.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit

class SeccondTableViewCell: UITableViewCell {
    
    static let reuseableIdentifier = "SeccondTableViewCell"
    
    let titleLabel = UILabel()
    lazy var collecionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        all()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func all(){
        configureHierarchy()
        configureLayout()
        designView()
        registers()
    }
    
    func registers(){
        collecionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.reuseIdenti)
    }
    
    func configureHierarchy(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(collecionView)
    }
    func configureLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        collecionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.greaterThanOrEqualTo(180).priority(900)
        }
    }
    func designView(){
        self.backgroundColor = .blue
        collecionView.backgroundColor = .red
        titleLabel.backgroundColor = .white
        
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.scrollDirection = .horizontal
        
        return layout
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}

