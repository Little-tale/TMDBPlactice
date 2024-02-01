//
//  SeccondTableViewCell.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit

class SeccondTableViewCell: BasicTableViewCell {
    
    static let reuseableIdentifier = "SeccondTableViewCell"
    
    let titleLabel = TrendHederLabel()
    
    lazy var collecionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())


    override func all(){
        super.all()
        registers()
    }
    
    func registers(){
        collecionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.reuseIdenti)
    }
    
    override func configureHierarchy(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(collecionView)
    }
    override func configureLayout(){
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(28)
        }
        collecionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.greaterThanOrEqualTo(180).priority(900)
        }
    }
    override func designView(){
       
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prepare(headerName: nil)
    }
    func prepare(headerName: String?) {
        titleLabel.text = headerName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

