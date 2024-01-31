//
//  BasicTableViewCell.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 1/31/24.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        all()
    }
    //스토리 보드 대응
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        all()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func all(){
        configureHierarchy()
        configureLayout()
        designView()
    }
    
    func configureHierarchy(){
        
    }
    func configureLayout(){
        
    }
    func designView(){
        
    }
    

}
