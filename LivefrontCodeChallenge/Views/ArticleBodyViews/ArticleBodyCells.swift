//
//  ArticleBodyCells.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

/// Paragraph cell for article body 
class ArticleBodyCell: UICollectionViewCell {
    
    var paragraphString: String? {
        didSet {
            guard let paragraphString = paragraphString else { return }
            paragraphLabel.text = paragraphString
        }
    }
    
    // Article paragraph label
    let paragraphLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .dynamicColor(light: .black, dark: .lightGray)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        backgroundColor = .dynamicColor(light: .white, dark: .systemGray6)
        
        // Anchor article paragraph label
        addSubview(paragraphLabel)
        paragraphLabel
            .anchor(top: topAnchor, left: leftAnchor,
                    bottom: bottomAnchor, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
