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
    
    // Cell identifiers
    var topArticleCellID = "TopArticleCellID"
    var basicArticleCellID = "basicArticleCellID"
    var headerCellID = "headerCellID"
    
    // Creating a rect of status bar frame
    var statusBarFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var articleViewModels = [ArticleViewModel]()
    let spinner = SpinnerViewController()
    
    /// Param used to first load of all popular articles today
    var articleAPIReturnRange: NYT_APITimeframes = .today
    
    /// Value of current pages title inside cell, starting with today. This updates when the setting is changed
    var currentPageIndexTitle: NYT_APITimeframeText = .trendingToday
    
    private var refreshControl = UIRefreshControl()
    
    /// Custom collectionView
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
        fetchArticleDataWith(timeFrame: articleAPIReturnRange)
    }
    
    /// Adds a custom view behind the status bar so it looks prettier
    fileprivate func setupStatusBarView() {
        navigationController?.navigationBar.isHidden = true
        
        if #available(iOS 13.0, *) {
            let window = UIApplication
                .shared
                .windows
                .filter {$0.isKeyWindow}.first
            statusBarFrame = window?
                .windowScene?
                .statusBarManager?
                .statusBarFrame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = .dynamicColor(light: .systemGray6, dark: .black)
        view.addSubview(statusBarView)
    }
    
    /// All collectionView properties and setup as well as attaching to viewController
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // Register collectionView cells
        collectionView.register(TopArticleCell.self, forCellWithReuseIdentifier: topArticleCellID)
        collectionView.register(BasicArticleCell.self, forCellWithReuseIdentifier: basicArticleCellID)
        collectionView.register(HomeHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID)
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = .dynamicColor(light: .systemGray6, dark: .black)
        // Attach refreshControl to the collectionView
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        // Add target to refresh control
        refreshControl.addTarget(self, action: #selector(refreshHomePage), for: .valueChanged)
        
        // Anchor collectionView
        view.addSubview(collectionView)
        collectionView
            .anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
                    bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor,
                    centerX: nil, centerY: nil,
                    paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                    width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    /// Refresh home page
    @objc fileprivate func refreshHomePage() {
        fetchArticleDataWith(timeFrame: articleAPIReturnRange)
    }
    
    /// Fetches articles with timeFrame param. Params are specified in the NYT_APIService documentation
    func fetchArticleDataWith(timeFrame: NYT_APITimeframes) {
        // First check if there is an internet connection present before we run networking methods
        if NetworkReachability.isConnectedToInternet {
            NYT_APIService.fetchPopularArticlesBy(timeframe: timeFrame) { [unowned self] articles, error in
                if let error = error {
                    print("Error fetching popular articles: ", error)
                    activateNoConnectionState()
                }
                self.articleViewModels = articles.map({ return ArticleViewModel(article: $0)})
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        } else {
            // No internet connection
            activateNoConnectionState()
        }
    }
    
    /// Puts the app in a state displaying to the user that there is currently no connection available
    fileprivate func activateNoConnectionState() {
        DispatchQueue.main.async {
            // If no internet connection found then we will hide the skeleton views
            self.reloadArticleCellsDelegate?.hideCellSkeletonView()
            self.reloadBasicArticleCellsDelegate.forEach { delegate in
                delegate.hideCellSkeletonView()
            }
            self.articleViewModels.removeAll()
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
            self.createSpinnerView()
            self.spinner.showNoConnectionStatus()
        }
    }
    
    /// Creates a custom spinner indicator to show loading process
    fileprivate func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        collectionView.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
}
