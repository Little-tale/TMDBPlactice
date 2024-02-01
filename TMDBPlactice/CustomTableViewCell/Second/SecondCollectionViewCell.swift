//
//  SecondCollectionViewCell.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit
import SnapKit
import Kingfisher

class SecondCollectionViewCell: BasicCollecionViewCell {
    let titleLabel = TrendPosterLabel()
    let imageView = UIImageView()
    static let reuseIdenti = "SecondCollectionViewCell"
    
    
    override func configureHierarchy(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    override func configureLayout(){
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
    override func designView(){
        imageView.backgroundColor = .cyan
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    // MARK: 재사용시 초기화 해줌 아주 착한 친구임
    // 잘 기억해
    override func prepareForReuse() {
        prepare(imageUrl: nil, labelText: nil)
    }
    func prepare(imageUrl : URL?, labelText: String? ) {
        
        imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "star"),options:[
            .transition(.fade(0.5)),
            .forceTransition
          ])
        titleLabel.text = labelText
    }
    
    
    
}
