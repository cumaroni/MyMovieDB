//
//  BaseSource.swift
//  MyMovieDB
//
//  Created by Roni Doang on 13/06/23.
//

import UIKit

// screen for root view
public private(set) var mainScreen = UIScreen.main.fixedCoordinateSpace.bounds

public class BaseSource {
    
    public static var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    public static var navbar: UINavigationController? {
        return BaseSource.window?.rootViewController as? UINavigationController
    }
}
