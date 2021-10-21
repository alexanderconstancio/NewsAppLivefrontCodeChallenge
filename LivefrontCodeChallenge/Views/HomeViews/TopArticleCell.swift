//
//  ArticleCell.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/5/21.
//

import UIKit
import SkeletonView
import DropDown
import Nuke

class TopArticleCell: UICollectionViewCell {
    weak var shareSheetDelegate: ActionSheetPresenterDelegate?
    /// Custom settings dropdown menu
    let articleOptionsDropDown = CellMenuDropdown()
    let dateRangeDropDown = CellMenuDropdown()
    
    var articleViewModel: ArticleViewModel? {
        didSet {
            guard let articleViewModel = articleViewModel else { return }
            self.articleTitleLabel.text = articleViewModel.title
            self.byLabel.text = articleViewModel.byline
            self.dateLabel.text = articleViewModel.date
            
            /* I know this is strange lol but I needed a non-image url so that NUKE will
             throw and error and provide me with the failure
            image when one is not available. */
            let thumb = articleViewModel.jsonImg.metaData.last?.url ?? "https://www.google.com/"
            let mediaUrl = URL(string: thumb)
            let options = ImageLoadingOptions(failureImage: #imageLiteral(resourceName: "image-not-found"))
            Nuke.loadImage(with: mediaUrl!, options: options, into: articleImg)
        }
    }
    
    /// Container that lets us add a corner radius and set background color
    let topCellContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .dynamicColor(light: .white, dark: .systemGray6)
        return view
    }()
    
    /// Primary article image
    var articleImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 50 / 2
        img.isSkeletonable = true
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    /// Label showing fetched article timeframes
    let timeFrameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 24, weight: .black)
        label.textColor = .systemGray
        return label
    }()
    
    /// Label showing the articles author
    let byLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .systemGray
        return label
    }()
    
    /// Label showing the article title
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 23, weight: .black)
        return label
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    /// Small button on bottom right to present article menu
    lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(showCellOptionsMenu), for: .touchUpInside)
        button.tintColor = .systemIndigo
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .systemIndigo
        return label
    }()
    
    /// Presents dropdown menu to change
    let changeArticleRangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "dropdown-arrow"), for: .normal)
        button.tintColor = .systemIndigo
        button.addTarget(self, action: #selector(showDateRangeMenu), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupMenuDropdown()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
