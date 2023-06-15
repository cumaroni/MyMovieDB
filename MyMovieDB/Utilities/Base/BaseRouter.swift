//
//  BaseRouter.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import UIKit

class BaseRouter {
    
    class func createNavbar(_ root: UIViewController) -> UINavigationController {
        let navBar = UINavigationController(rootViewController: root)
        navBar.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navBar.navigationBar.shadowImage = UIImage()
        navBar.navigationBar.isTranslucent = true
        navBar.navigationBar.tintColor = .clear
        navBar.view.backgroundColor = .clear
        navBar.setNavigationBarHidden(true, animated: true)
        return navBar
    } 
}
