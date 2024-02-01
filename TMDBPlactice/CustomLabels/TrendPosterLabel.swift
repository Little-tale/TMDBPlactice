//
//  TrendPosterLabel.swift
//  TMDBPlactice
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

class TrendPosterLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        design()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        design()
    }
    
    func design() {
        backgroundColor = UIColor(white: 1, alpha: 0.75)
        font = .systemFont(ofSize: 14, weight: .light)
        self.textAlignment = .center
    }
}
