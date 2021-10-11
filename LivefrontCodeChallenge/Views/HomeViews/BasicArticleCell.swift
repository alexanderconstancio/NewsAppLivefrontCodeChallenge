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
            
            // I know this is strange lol but I needed a non-image url so that NUKE will throw and error and provide me with the failure
            // image when one is not available.
            let thumb = articleViewModel.jsonImg.metaData.last?.url ?? "https://www.google.com/"
            let mediaUrl = URL(string: thumb)
            let options = ImageLoadingOptions(failureImage: #imageLiteral(resourceName: "image-not-found"))
            Nuke.loadImage(with: mediaUrl!, options: options, into: articleImg)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupMenuDropdown()
    }
    
    let basicCellContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = .dynamicColor(light: .white, dark: .systemGray6)
        return view
    }()
    
    let articleImgSize: CGFloat = 50
    let articleImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 18
        img.isSkeletonable = true
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
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
    
    lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        button.tintColor = .systemIndigo
        return button
    }()
    
    @objc func showMenu() {
        dropDown.show()
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.linesCornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        label.textColor = .systemIndigo
        return label
    }()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
