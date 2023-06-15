//
//  ApiResponse.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import SwiftyJSON

public struct ApiResponse<Element: ApiModel>: ApiModel {
    
    public private(set) var data: [Element] = []
    public private(set) var model: Element! = Element(json: JSON.init(parseJSON: ""))
    public private(set) var totalResult: Int = 0
    public private(set) var JSONResponse: JSON = JSON(parseJSON: "")
      
    public init(json: JSON) {
        JSONResponse = json
        
        guard json["results"].arrayValue.count > 0 else {
            // model
            model = Element(json: json)
            return
        }
        
        // array
        data = json["results"].arrayValue.map { value in
            return Element(json: value)
        }
        
        totalResult = json["total_results"].intValue
    }
}
