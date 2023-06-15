//
//  Api.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//

import Alamofire
import SwiftyJSON

public class API<T: ApiModel> {
    
    private var requestHeader: HTTPHeaders {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OWM1MTYyYzhjZTMyOGZlODgwNzYwODBlZmUxNzFjMyIsInN1YiI6IjY0ODgyYTVjZTM3NWMwMDEzOWMxYmI5YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qef1JeHhS2JESU4MwpxuA1bZF7_aez9xEJgoRvO0pVo"
        ]
        return headers
    }
    
    public func request(
        _ data: ApiRequest,
        onSuccess: @escaping (ApiResponse<T>)->Void,
        onError: @escaping (ApiError)->Void,
        request: ((DataRequest)->Void)? = nil)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        func requestAPI() {
            DispatchQueue.global(qos: .utility).async {
                print("\(data.path) : request") 
                let apiRequest = AF
                    .request(
                        "https://api.themoviedb.org/3/" + data.path,
                        method: data.method,
                        parameters: data.params,
                        encoding: URLEncoding.default
//                        headers: self.requestHeader
                    )
                    .responseJSON(completionHandler: { (response) in
                        self.responseJSON(
                            response: response,
                            onSuccess: onSuccess,
                            onError: onError
                        )
                    })
                print(data.params)
                print(apiRequest)
                request?(apiRequest)
            }
        }
        requestAPI()
    }
    
    private func responseJSON<T: ApiModel>(
        response: AFDataResponse<Any>,
        onSuccess: @escaping (ApiResponse<T>)->Void,
        onError: @escaping (ApiError)->Void)
    {
        guard let statusCode = response.response?.statusCode else {
            ApiManager.shared.delegate?.ApiRequestTimeOut(
                isReachable: ApiManager.shared.isReachable
            )
            setError(onError: onError)
            return
        } 
        switch response.result {
        case .success(let value):
            onRequestSuccess(
                value,
                statusCode: statusCode,
                onSuccess: onSuccess,
                onError: onError
            )
        case .failure(let error):
            onRequestFailed(
                error,
                jsonData: response.result,
                statusCode: statusCode,
                onError: onError
            )
        }
        
    }
    
    private func setError(onError: @escaping (ApiError)-> Void) {
        let error = ApiError(json: JSON(parseJSON: ""), error: "", code: 0)
        onError(error)
    }
    
    private func onRequestSuccess<T: ApiModel>(
        _ result: Any,
        statusCode: Int,
        onSuccess: @escaping (ApiResponse<T>)->Void,
        onError: @escaping (ApiError)->Void
    ) {
        let json = JSON(result)
        let model = ApiResponse<T>(json: json)
        let error = ApiError(json: json, error: "", code: statusCode)
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(json["success"])
            if json["success"] == false {
                onError(error)
            } else {
                onSuccess(model)
            }
            
        }
    }
    
    private func onRequestFailed(
        _ error: AFError,
        jsonData: Any?,
        statusCode: Int,
        onError: @escaping (ApiError)->Void
    ) {
        if isNotModifiedResponse(statusCode) {
            return
        }
        
        if isInvalidTokenResponse(statusCode) {
            ApiManager.shared.delegate?.ApiInvalidToken(
                error,
                isReachable: ApiManager.shared.isReachable
            )
            return
        }
        if isNotFoundResponse(statusCode) {
            ApiManager.shared.delegate?.ApiNotFound(
                error,
                isReachable: ApiManager.shared.isReachable
            )
            return
        }
        
        if isInternalServerErrorResponse(statusCode) {
            onError(
                ApiError(
                    json: .null,
                    error: statusCodeFullText(statusCode),
                    code: statusCode
                )
            )
            ApiManager.shared.delegate?.ApiInternalServerError(
                error,
                isReachable: ApiManager.shared.isReachable
            )
            return
        }
        
        guard let value = jsonData else {
            onError(
                ApiError(
                    json: .null,
                    error: statusCodeFullText(statusCode),
                    code: statusCode
                )
            )
            return
        }
        
        let json = JSON(value)
        guard json != .null else {
            onError(
                ApiError(
                    json: .null,
                    error: statusCodeFullText(statusCode),
                    code: statusCode
                )
            )
            return
        }
        
        let error = ApiError(json: json, error: "Unable to complete the request", code: statusCode)
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            onError(error)
        }
    }
    
    private func isNotModifiedResponse(_ statusCode: Int) -> Bool {
        return statusCode == 304
    }
    
    private func isInvalidTokenResponse(_ statusCode: Int) -> Bool {
        return statusCode == 401
    }
    
    private func isNotFoundResponse(_ statusCode: Int) -> Bool {
        return (statusCode == 403 || statusCode == 404)
    }
    
    private func isInternalServerErrorResponse(_ statusCode: Int) -> Bool {
        return statusCode == 500
    }
    
    private func statusCodeFullText(_ code: Int) -> String {
        var result = "\(code) - "
        switch code {
        case 100: result += "Continue"
        case 101: result += "Switching Protocols"
        case 102: result += "Processing"
        case 103: result += "Early Hints"
        case 200: result += "OK"
        case 201: result += "Created"
        case 202: result += "Accepted"
        case 203: result += "Non-Authoritative Information"
        case 204: result += "No Content"
        case 205: result += "Reset Content"
        case 206: result += "Partial Content"
        case 207: result += "Multi-Status"
        case 208: result += "Already Reported"
        case 226: result += "IM Used"
        case 300: result += "Multiple Choices"
        case 301: result += "Move Permanently"
        case 302: result += "Found"
        case 303: result += "See Other"
        case 304: result += "Not Modified"
        case 305: result += "Use Proxy"
        case 306: result += "Switch Proxy"
        case 307: result += "Temporary Redirect"
        case 308: result += "Permanent Redirect"
        case 400: result += "Bad Requset"
        case 401: result += "Unauthorized"
        case 402: result += "Payment Required"
        case 403: result += "Forbidden"
        case 404: result += "Not Found"
        case 405: result += "Method Not Allowed"
        case 406: result += "Not Acceptable"
        case 407: result += "Proxy Authentication Required"
        case 408: result += "Requset Timeout"
        case 409: result += "Conflict"
        case 410: result += "Gone"
        case 411: result += "Length Required"
        case 412: result += "Precondition Failed"
        case 413: result += "Payload Too Large"
        case 414: result += "URI Too Long"
        case 415: result += "Unsupported Media Type"
        case 416: result += "Range Not Satisflable"
        case 417: result += "Expectation Falied"
        case 418: result += "I'm a teapot"
        case 421: result += "Misdirected Request"
        case 422: result += "Unprocessable Entity"
        case 423: result += "Locked"
        case 424: result += "Failed Dependency"
        case 426: result += "Upgrade Required"
        case 428: result += "Precondition Required"
        case 429: result += "Too Many Requsets"
        case 431: result += "Requset Header Fields Too Large"
        case 451: result += "Unavailable For Legal Reasons"
        case 500: result += "Internal Server Error"
        case 501: result += "Not Implemented"
        case 502: result += "Bad Gateway"
        case 503: result += "Service Unavailable"
        case 504: result += "Gateway Timeout"
        case 505: result += "HTTP Version Not Supported"
        case 506: result += "Variant Also Negotiates"
        case 507: result += "Insufficient Storage"
        case 508: result += "Loop Detected"
        case 510: result += "Not Extended"
        case 511: result += "Network Authentication Required"
        default: result += "Undefined Status Code"
        }
        return result
    }
    
}
