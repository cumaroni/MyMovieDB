//
//  ApiDelegate.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import Foundation 

public protocol ApiDelegate {
    
    func ApiRequestTimeOut(isReachable: Bool)
    func ApiNotFound(_ error: Error, isReachable: Bool)
    func ApiInternalServerError(_ error: Error, isReachable: Bool) 
    func ApiInvalidToken(_ error: Error, isReachable: Bool)
    
}
