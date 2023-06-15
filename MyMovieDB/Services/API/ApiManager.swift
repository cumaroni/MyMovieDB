//
//  ApiManager.swift
//  MyMovieDB
//
//  Created by Roni Doang on 14/06/23.
//
 
import Alamofire

class ApiManager {
     
    public static let shared = ApiManager()
    public var isReachable: Bool = false
    private let manager = NetworkReachabilityManager(host: "www.apple.com") 
    internal var delegate: ApiDelegate?
    
    private init() {
        manager?.startListening { status in
            switch status {
                case .notReachable :
                    self.isReachable = false
                case .reachable(.cellular) :
                    self.isReachable = true
                case .reachable(.ethernetOrWiFi) :
                    self.isReachable = true
                default :
                    self.isReachable = false
            }
        }
    }
    
    public func set(delegate: ApiDelegate?) {
        self.delegate = delegate
    }
}
