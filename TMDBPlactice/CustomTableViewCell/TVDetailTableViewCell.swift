//
//  TVDetailTableViewCell.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 1/31/24.
//

import UIKit
import SnapKit

/*
 1. 이미지 뷰 필요
 2. 이름 라벨 필요
 3. 설명 라벨 필요
 */

class TVDetailTableViewCell: BasicTableViewCell {
    
    static let reusableIdentifier = "TVDetailTableViewCell"
    
    let infoLabel = UILabel()
    
    let originalNameLabel = UILabel()
    let overViewLabel = UILabel()
    let posterImageView = UIImageView()
    
    
    // 코드 베이스 대응
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        designView()
    }
    //스토리 보드 대응
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    override func all(){
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    override func configureHierarchy(){
        contentView.addSubview(posterImageView)
        contentView.addSubview(originalNameLabel)
        contentView.addSubview(overViewLabel)
    }
    override func configureLayout(){
        posterImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView).inset(8)
            make.width.equalTo(80)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5).priority(930)
        }
        originalNameLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(12)
            make.height.equalTo(30).priority(900)
        }
        overViewLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(12)
            make.top.equalTo(originalNameLabel.snp.bottom).inset(4)
        }
    }
    override func designView(){
        posterImageView.backgroundColor = .orange
        originalNameLabel.backgroundColor = .gray
        overViewLabel.numberOfLines = 0
        overViewLabel.backgroundColor = .lightGray
        
        //    func collecionViewLayout() -> UICollectionViewLayout{
        //        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 150 )
        //        layout.minimumLineSpacing = 8
        //        layout.minimumInteritemSpacing = 0
        //        layout.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        //
        //        layout.scrollDirection = .horizontal
        //
        //
        //        return layout
        //    }
        
        
    }
}
#Preview {
    ViewController()
}
