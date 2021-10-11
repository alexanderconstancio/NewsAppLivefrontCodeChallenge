//
//  ArticleBodyHeaderCell.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit
import Nuke

class ArticleBodyHeaderCell: UICollectionViewCell {
    
    var articleBodyViewModel: ArticleBodyViewModel? {
        didSet {
            guard let articleBodyViewModel = articleBodyViewModel else { return }
            articleTitleLabel.text = articleBodyViewModel.titleLabel
            byLabel.text = articleBodyViewModel.byLabel
            dateLabel.text = articleBodyViewModel.dateLabel
            
            /* I know this is strange lol but I needed a non-image url so that NUKE will
             throw and error and provide me with the failure
            image when one is not available. */
            let thumb = articleBodyViewModel.jsonImg.metaData.last?.url ?? "https://www.google.com/"
            let mediaUrl = URL(string: thumb)
            
            let options = ImageLoadingOptions(failureImage: #imageLiteral(resourceName: "image-not-found"))
            Nuke.loadImage(with: mediaUrl!, options: options, into: articleImg)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    fileprivate func setupViews() {
        backgroundColor = .dynamicColor(light: .white, dark: .systemGray6)
        
        addSubview(articleImg)
        articleImg.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250, xPadding: 0, yPadding: 0)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, centerX: centerXAnchor, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        addSubview(byLabel)
        byLabel.anchor(top: nil, left: leftAnchor, bottom: dateLabel.topAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 5, paddingRight: 30, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        addSubview(articleTitleLabel)
        articleTitleLabel.anchor(top: articleImg.bottomAnchor, left: leftAnchor, bottom: byLabel.topAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    var articleImg: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.numberOfLines = 4
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .black)
        return label
    }()
    
    let byLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .systemIndigo
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
