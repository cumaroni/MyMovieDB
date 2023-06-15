//
//  HomeRouter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import UIKit

final class HomeRouter: HomeRouterDelegate {
    weak var source: UIViewController?
    
    init(view: HomeViewControllerDelegate?) {
        source = view as? UIViewController
    }
}
