//
//  ApiError.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import SwiftyJSON

public struct ApiError {
    
    public let json: JSON
    public let statusCode: Int
    public let localizedDescription: String
    
    public var messages: String {
        return json["status_message"].stringValue
    }
    
    init(json: JSON, error: String, code: Int) {
        self.json = json
        self.statusCode = code
        self.localizedDescription = error
    }
    
}
