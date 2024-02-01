//
//  SecondCollectionViewCell.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    static let reuseIdenti = "SecondCollectionViewCell"
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        all()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        all()
    }
    func all(){
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    func configureHierarchy(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    func configureLayout(){
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView).inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.horizontalEdges.equalTo(imageView)
            make.height.equalTo(20)
        }
    }
    func designView(){
        imageView.backgroundColor = .cyan
        titleLabel.backgroundColor = .orange
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
}
