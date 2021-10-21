//
//  HomeHeaderCell.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/7/21.
//

import Foundation
import UIKit

class HomeHeaderCell: UICollectionViewCell {
    /// News! text label
    let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "News!"
        label.font = UIFont.systemFont(ofSize: 36, weight: .black)
        return label
    }()
    
    /// Todays date label
    let dateLabel: UILabel = {
        let date = Date()
        let dateText = "\(date.month) \(date.get(.day))"
        
        let label = UILabel()
        label.text = dateText
        label.font = UIFont.systemFont(ofSize: 36, weight: .black)
        label.textColor = .systemIndigo
        return label
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /// Layout all subviews
    fileprivate func setupViews() {
        // Anchor date label
        addSubview(dateLabel)
        dateLabel
            .anchor(top: nil, left: leftAnchor,
                    bottom: bottomAnchor, right: nil,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor New! label
        addSubview(newsLabel)
        newsLabel
            .anchor(top: nil, left: leftAnchor,
                    bottom: dateLabel.topAnchor, right: nil,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 10, paddingBottom: -5, paddingRight: 0,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor small gray separator line
        addSubview(separatorLineView)
        separatorLineView
            .anchor(top: nil, left: leftAnchor,
                    bottom: bottomAnchor, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10,
                    width: 0, height: 0.3, xPadding: 0, yPadding: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
