//
//  Ext-TopArticleCellSubViews.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/9/21.
//

import Foundation
import UIKit
import SkeletonView

extension TopArticleCell {
    
    /// Presents date range dropdown for article range
    @objc func showDateRangeMenu() {
        dateRangeDropDown.show()
    }
    
    /// Hides skeleton loading indicators for the home screen collectionView
    func hideAnimation() {
        articleImg.hideSkeleton()
        articleTitleLabel.hideSkeleton()
        byLabel.hideSkeleton()
        timeFrameLabel.hideSkeleton()
        
        separatorLineView.isHidden = false
        dateLabel.isHidden = false
        optionsButton.isHidden = false
        changeArticleRangeButton.isHidden = false
        byLabel.isHidden = false
    }
    
    /// Activates skeleton loading indicators for the home screen collectionView
    func showSkeletonAnimation() {
        // We need to animate the skeleton asynchronously because otherwise it will be executed before the views are drawn
        DispatchQueue.main.async {
            self.timeFrameLabel.showAnimatedGradientSkeleton()
            self.articleImg.showAnimatedGradientSkeleton()
            self.articleTitleLabel.showAnimatedGradientSkeleton()
            self.byLabel.showAnimatedGradientSkeleton()
            
            self.byLabel.isHidden = true
            self.optionsButton.isHidden = true
            self.dateLabel.isHidden = true
            self.changeArticleRangeButton.isHidden = true
        }
    }
    
    /// Setup for the cells drop down menus, article options and date range options
    func setupMenuDropdown() {
        // Setup for cell options menu
        articleOptionsDropDown.setupCustomDropdown(options: ["Share", "Copy link"], anchorButton: optionsButton)
        articleOptionsDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if index == 0 {
                self.presentShareSheet()
            } else if index == 1 {
                self.copyToClipboard()
            }
            self.articleOptionsDropDown.clearSelection()
        }
        
        // Setup for article list timeframe menu
        dateRangeDropDown.setupCustomDropdown(options: ["Today", "Past week", "Last 30 days"], anchorButton: changeArticleRangeButton)
        dateRangeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        
            if index == 0 {
                // Today option selected. Param: 1
                shareSheetDelegate?.dateRangeSelected(inRange: 1)
            } else if index == 1 {
                // last 7 days option selected. Param: 7
                shareSheetDelegate?.dateRangeSelected(inRange: 7)
            } else if index == 2 {
                // last 30 days selected: Param: 30
                shareSheetDelegate?.dateRangeSelected(inRange: 30)
            }
            self.dateRangeDropDown.clearSelection()
        }
    }
    
    /// Prove with the cells article URL and this will present a share sheet
    fileprivate func presentShareSheet() {
        guard let articleUrl = articleViewModel?.url else { return }
        guard let url = URL(string: articleUrl) else {
            return
        }
        
        let shareSheetVC = UIActivityViewController(activityItems: [url], applicationActivities: .none)
        shareSheetDelegate?.presentActionSheet(forSheet: shareSheetVC)
    }
    
    /// You guessed it, copies article link to the clipboard
    fileprivate func copyToClipboard() {
        guard let articleUrl = articleViewModel?.url else { return }
        UIPasteboard.general.string = articleUrl
        
        shareSheetDelegate?.showCopyToClipAlert()
    }
    
    /// Show dropdown menu for article cell options
    @objc func showCellOptionsMenu() {
        articleOptionsDropDown.show()
    }
    
    /// Sets background color for cell and anchors all of the cells subviews
    func setupViews() {
        contentView.isUserInteractionEnabled = false
        backgroundColor = .dynamicColor(light: .systemGray6, dark: .black)
        
        // Anchor timeFrameLabel
        addSubview(timeFrameLabel)
        timeFrameLabel
            .anchor(top: topAnchor, left: leftAnchor,
                    bottom: nil, right: nil,
                    centerX: nil, centerY: nil,
                    paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor container view and send it to the back
        addSubview(topCellContainerView)
        sendSubviewToBack(topCellContainerView)
        topCellContainerView
            .anchor(top: topAnchor, left: leftAnchor,
                    bottom: bottomAnchor, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor article image
        addSubview(articleImg)
        articleImg
            .anchor(top: topCellContainerView.topAnchor, left: leftAnchor,
                    bottom: nil, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                    width: 0, height: 250, xPadding: 0, yPadding: 0)
        
        // Anchor article range dropdown button
        addSubview(changeArticleRangeButton)
        changeArticleRangeButton
            .anchor(top: nil, left: timeFrameLabel.rightAnchor,
                    bottom: nil, right: nil,
                    centerX: nil, centerY: timeFrameLabel.centerYAnchor,
                    paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0,
                    width: 30, height: 30, xPadding: 0, yPadding: 0)
        
        // Anchor article author label
        addSubview(byLabel)
        byLabel
            .anchor(top: articleImg.bottomAnchor, left: leftAnchor,
                    bottom: nil, right: nil,
                    centerX: nil, centerY: nil,
                    paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0,
                    width: 250, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor article title label
        addSubview(articleTitleLabel)
        articleTitleLabel
            .anchor(top: byLabel.bottomAnchor, left: leftAnchor,
                    bottom: nil, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 5, paddingLeft: 15, paddingBottom: 0, paddingRight: 15,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor small bottom separator line
        addSubview(separatorLineView)
        separatorLineView
            .anchor(top: nil, left: leftAnchor,
                    bottom: bottomAnchor, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 0, paddingBottom: 40, paddingRight: 0,
                    width: 0, height: 0.4, xPadding: 0, yPadding: 0)
        
        // Anchor article date label
        addSubview(dateLabel)
        dateLabel
            .anchor(top: nil, left: leftAnchor,
                    bottom: bottomAnchor, right: nil,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 15, paddingBottom: 10, paddingRight: 0,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
        
        // Anchor small dropdown options button
        addSubview(optionsButton)
        optionsButton
            .anchor(top: nil, left: nil,
                    bottom: bottomAnchor, right: rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 10,
                    width: 30, height: 30, xPadding: 0, yPadding: 0)
    }
}
