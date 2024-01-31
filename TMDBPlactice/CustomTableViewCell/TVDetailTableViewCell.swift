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
    
    let originalNameLabel = UILabel()
    let overViewLabel = UILabel()
    let posterImageView = UIImageView()
    let dateLabel = UILabel()
    
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
        contentView.addSubview(dateLabel)
    }
    override func configureLayout(){
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(contentView).inset(12)
            make.height.equalTo(UIScreen.main.bounds.height / 1.7).priority(900)
        }
        overViewLabel.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).inset(12)
            make.horizontalEdges.equalTo(posterImageView).inset(8)
            make.height.equalTo(80)
        }
        originalNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(overViewLabel.snp.top).inset(4)
            make.leading.equalTo(overViewLabel)
            make.height.equalTo(40)
            make.width.greaterThanOrEqualTo(UIScreen.main.bounds.width / 2)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(overViewLabel.snp.top).inset(-2)
            make.trailing.equalTo(contentView).inset(4)
            make.leading.equalTo(originalNameLabel.snp.trailing).inset(4)
            make.width.greaterThanOrEqualTo(100).priority(900)
            make.height.equalTo(20)
        }
        
    }
    override func designView(){
        posterImageView.alpha = 0.5
        posterImageView.backgroundColor = .orange
        originalNameLabel.backgroundColor = UIColor(displayP3Red: 54, green: 52, blue: 56, alpha: 0.7)
        overViewLabel.numberOfLines = 0
        overViewLabel.backgroundColor = UIColor(displayP3Red: 54, green: 52, blue: 56, alpha: 0.7)
        overViewLabel.font = .systemFont(ofSize: 16, weight: .light)
        
        originalNameLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        print(UIScreen.main.bounds.height / 10 )
        
        //dateLabel.backgroundColor = .gray
        //originalNameLabel.backgroundColor = .red
    }
}
//#Preview {
//    ViewController()
//}



/*
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
 */
