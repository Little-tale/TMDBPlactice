//
//  TrendHederLabel.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/1/24.
//

import UIKit

class TrendHederLabel: UILabel {
    let line = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configualHierachy()
        design()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

   
    func configualHierachy(){
        layer.addSublayer(line)
    }
    func design() {
        self.font = .systemFont(ofSize: 20, weight: .semibold)
        self.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        line.borderColor = UIColor.systemGray4.cgColor
        line.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 5)
        line.borderWidth = 1
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        design()
    }
    
}
