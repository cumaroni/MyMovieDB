//
//  UITableView+Extensions.swift
//  MyMovieDB
//
//  Created by Roni Doang on 15/06/23.
//

import Foundation
import UIKit

extension UITableView {
    
    private var loadingViewTag: Int { return 9999 } 
    
    public func showLoadingView() {
        guard viewWithTag(loadingViewTag) == nil else { return }
        let loadingView = UIView(frame: bounds)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        loadingView.tag = loadingViewTag

        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()

        loadingView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true

        addSubview(loadingView)
    }
    
    public func hideLoadingVIew() {
        guard let loadingView = viewWithTag(loadingViewTag) else { return }
        loadingView.removeFromSuperview()
    }
}

