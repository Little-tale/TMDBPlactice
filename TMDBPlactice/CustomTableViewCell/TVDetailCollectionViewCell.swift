/*
 필요한것
 1. 이미지뷰
 2. 드라마 정보 레이블
 3. 드라마 이름 레이블
 */

import UIKit
import SnapKit

class TVDetailCollectionViewCell: UICollectionViewCell {
    
    let originalNameLabel = UILabel()
    let posterImageView = UIImageView()
    
    static let reusuableIdentifier = "TVDetailCollectionViewCell"
    
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(originalNameLabel)
    }
    func configureLayout(){
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        originalNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.height.equalTo(20)
        }
    }
    func designView(){
        posterImageView.backgroundColor = .orange
        originalNameLabel.backgroundColor = .gray
    }
}

#Preview {
    ViewController()
}
