//
//  ArticleBodyViewController.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

class ArticleBodyViewController: UIViewController {
    
    var articleParagraphs = [String]()
    
    var bodyCellID = "bodyCellID"
    var bodyHeaderCellID = "bodyHeaderCellID"
    
    var articleBodyViewModel: ArticleBodyViewModel?
    
    let spinner = SpinnerViewController()
    
    var article: ArticleViewModel? {
        didSet {
            guard let article = article else {
                return
            }

            // Load article body async so that the view will display until data is available 
            DispatchQueue.main.async {
                self.articleBodyViewModel = ArticleBodyViewModel(article: article)
                self.articleBodyViewModel?.articleParagraphs.forEach({ p in
                    self.articleParagraphs.append(p)
                })
                
                self.spinner.willMove(toParent: nil)
                self.spinner.view.removeFromSuperview()
                self.spinner.removeFromParent()
                
                self.collectionView.reloadData()
            }
        }
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let CV = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        return CV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createSpinnerView()
    }
    
    /// All collectionView properties and setup
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ArticleBodyCell.self, forCellWithReuseIdentifier: bodyCellID)
        collectionView.register(ArticleBodyHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: bodyHeaderCellID)
        
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = .dynamicColor(light: .white, dark: .systemGray6)
        collectionView.alwaysBounceVertical = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    /// Creates a custom spinner indicator to show loading process
    func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
}
