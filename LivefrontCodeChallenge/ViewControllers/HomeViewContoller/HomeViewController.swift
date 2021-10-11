//
//  ViewController.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 9/30/21.
//

import UIKit
import Alamofire
import SkeletonView

class HomeViewController: UIViewController {
    
    weak var reloadArticleCellsDelegate: ReloadNewArticlesDelegate?
    var reloadBasicArticleCellsDelegate = [ReloadBasicArticlesDelegate]()
    
    var topArticleCellID = "TopArticleCellID"
    var basicArticleCellID = "basicArticleCellID"
    var headerCellID = "headerCellID"
    
    var statusBarFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var articleViewModels = [ArticleViewModel]()
    let spinner = SpinnerViewController()
    
    /// Param used to first load of all popular articles today
    let popularArticlesToday = 1
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let CV = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        return CV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createSpinnerView()
        setupStatusBarView()
        
        // Initial load is done with 'today' param
        fetchArticleDataWith(timeFrame: popularArticlesToday)
    }
    
    /// Adds a custom view behind the status bar so it looks prettier
    fileprivate func setupStatusBarView() {
        navigationController?.navigationBar.isHidden = true
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = .dynamicColor(light: .systemGray6, dark: .black)
        view.addSubview(statusBarView)
    }
    
    /// All collectionView properties and setup
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TopArticleCell.self, forCellWithReuseIdentifier: topArticleCellID)
        collectionView.register(BasicArticleCell.self, forCellWithReuseIdentifier: basicArticleCellID)
        collectionView.register(HomeHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID)
        
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = .dynamicColor(light: .systemGray6, dark: .black)

        collectionView.alwaysBounceVertical = true
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    /// Fetches articles with timeFrame param. Params are specified in the NYT_APIService documentation
    func fetchArticleDataWith(timeFrame: Int) {
        NYT_APIService.fetchPopularArticlesBy(timeframe: timeFrame) { [unowned self] articles, error in
            if let error = error {
                print("Error fetching popular articles: ", error)
            }

            self.articleViewModels = articles.map({ return ArticleViewModel(article: $0)})
            self.collectionView.reloadData()
        }
    }
    
    /// Creates a custom spinner indicator to show loading process
    func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        collectionView.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
}
