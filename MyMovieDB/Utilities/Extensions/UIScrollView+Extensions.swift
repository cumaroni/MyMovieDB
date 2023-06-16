//
//  UIScrollView+Extensions.swift
//  MyMovieDB
//
//  Created by Roni Doang on 16/06/23.
//

import UIKit

extension UIScrollView {
    
    func showLoading() {
        let loadingView = UIView(frame: bounds)
        loadingView.backgroundColor = .black.withAlphaComponent(0.5)
        loadingView.tag = 999

        let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        loadingIndicator.center = loadingView.center
        loadingIndicator.startAnimating()

        loadingView.addSubview(loadingIndicator)
        addSubview(loadingView)

        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }

    func hideLoading() {
        if let loadingView = viewWithTag(999) {
            loadingView.removeFromSuperview()
        }
    }
}
