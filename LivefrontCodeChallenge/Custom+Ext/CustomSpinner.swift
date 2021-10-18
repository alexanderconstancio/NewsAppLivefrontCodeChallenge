//
//  CustomSpinner.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/10/21.
//

import Foundation
import UIKit

// Custom spinner to show app is in loading state
class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)
    
    /// No connection found image
    let noConnectionImg: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "no-wifi")
        img.tintColor = .systemIndigo
        img.isHidden = true
        return img
    }()
    
    /// No connection found label
    let noConnectionLabel: UILabel = {
        let label = UILabel()
        label.text = "You're offline\nPlease check your connection and refresh"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .dynamicColor(light: .black, dark: .lightGray)
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.isHidden = true
        return label
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(noConnectionImg)
        noConnectionImg
            .anchor(top: nil, left: nil, bottom: nil, right: nil,
                    centerX: view.centerXAnchor, centerY: view.centerYAnchor,
                    paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,
                    width: 100, height: 100, xPadding: 0, yPadding: -50)
        view.addSubview(noConnectionLabel)
        noConnectionLabel.anchor(top: noConnectionImg.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, xPadding: 0, yPadding: 0)
    }
    
    /// Unhides no connection image and label and stops the spinner
    public func showNoConnectionStatus() {
        spinner.stopAnimating()
        noConnectionImg.isHidden = false
        noConnectionLabel.isHidden = false
    }
    
    /// hides no connection image and label and stops the spinner
    public func hideNoConnectionStatus() {
        spinner.stopAnimating()
        noConnectionImg.isHidden = true
        noConnectionLabel.isHidden = true
    }
}
