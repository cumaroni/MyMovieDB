//
//  ApiRequest.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import Alamofire

public struct ApiRequest {
    
    internal let path: String
    internal let method: HTTPMethod
    internal let params: Parameters?
    
    public init(
        path: String,
        method: HTTPMethod,
        params: Parameters? = nil
    ) {
        self.path = path
        self.method = method
        self.params = params 
    }
}
