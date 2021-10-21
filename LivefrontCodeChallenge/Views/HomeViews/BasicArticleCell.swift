//
//  BasicArticleCell.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/8/21.
//

import UIKit
import SkeletonView
import DropDown
import Nuke

class BasicArticleCell: UICollectionViewCell {
    let dropDown = CellMenuDropdown()
    weak var shareSheetDelegate: ActionSheetPresenterDelegate?
    var articleViewModel: ArticleViewModel? {
        didSet {
            guard let articleViewModel = articleViewModel else { return }
            articleTitleLabel.text = articleViewModel.title
            dateLabel.text = articleViewModel.date
            
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
    let basicCellContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = .dynamicColor(light: .white, dark: .systemGray6)
        return view
    }()
    
    /// Primary article image
    let articleImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 18
        img.isSkeletonable = true
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    /// Article title label
    let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    /// Article cell options button
    lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        button.tintColor = .systemIndigo
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        label.textColor = .systemIndigo
        return label
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
