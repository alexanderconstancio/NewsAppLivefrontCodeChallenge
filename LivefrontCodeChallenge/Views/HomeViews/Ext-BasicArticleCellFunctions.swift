//
//  Ext-BasicArticleCellFunctions.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/9/21.
//

import Foundation
import UIKit
import DropDown

extension BasicArticleCell {
    
    /// Setup for the cells drop down menus, article options and date range options
    func setupMenuDropdown() {
        dropDown.setupCustomDropdown(options: ["Share", "Copy link"], anchorButton: optionsButton)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                self.presentShareSheet()
            } else if index == 1 {
                copyToClipboard()
            }
            self.dropDown.clearSelection()
        }
    }
    
    /// Prove with the cells article URL and this will present a share sheet
    fileprivate func presentShareSheet() {
        guard let articleUrl = articleViewModel?.url else { return }
        guard let url = URL(string: articleUrl) else {
            return
        }
        
        let shareSheetVC = UIActivityViewController(activityItems: [url], applicationActivities: .none)
        shareSheetDelegate?.presentActionSheet(sheet: shareSheetVC)
    }
    
    fileprivate func copyToClipboard() {
        guard let articleUrl = articleViewModel?.url else { return }
        UIPasteboard.general.string = articleUrl
        
        shareSheetDelegate?.showCopyToClipAlert()
    }
    
    /// Hides skeleton loading indicators for the home screen collectionView
    func hideAnimation() {
        articleImg.hideSkeleton()
        articleTitleLabel.hideSkeleton()
        separatorLineView.isHidden = false
        optionsButton.isHidden = false
        dateLabel.isHidden = false
    }
    
    /// Activates skeleton loading indicators for the home screen collectionView
    func showAnimatedSkeletonViews() {
        // We need to animate the skeleton asyncronously because otherwise it will be executed before the views are drawn
        DispatchQueue.main.async {
            self.articleImg.showAnimatedGradientSkeleton()
            self.articleTitleLabel.showAnimatedGradientSkeleton()
            self.separatorLineView.isHidden = true
            self.optionsButton.isHidden = true
            self.dateLabel.isHidden = true
        }
    }
    
    func setupViews() {
        backgroundColor = .dynamicColor(light: .systemGray6, dark: .black)
        contentView.isUserInteractionEnabled = false
        
        addSubview(basicCellContainerView)
        basicCellContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        addSubview(articleImg)
        articleImg.anchor(top: basicCellContainerView.topAnchor, left: basicCellContainerView.leftAnchor, bottom: nil, right: basicCellContainerView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 125, xPadding: 0, yPadding: 0)
        
        addSubview(articleTitleLabel)
        articleTitleLabel.anchor(top: articleImg.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, xPadding: 0, yPadding: 0)
       
        addSubview(separatorLineView)
        separatorLineView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 0.3, xPadding: 0, yPadding: 0)
        
        addSubview(optionsButton)
        optionsButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 8, width: 15, height: 15, xPadding: 0, yPadding: 0)
        bringSubviewToFront(optionsButton)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 8, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
}
