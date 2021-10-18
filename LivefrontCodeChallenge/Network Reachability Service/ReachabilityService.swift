//
//  ReachabilityService.swift
//  LivefrontCodeChallenge
//
//  Created by Alex Constancio on 10/18/21.
//

import Foundation
import Alamofire

public struct NetworkReachability {
  static let sharedInstance = NetworkReachabilityManager()!
    
    /// Returns true or false when an internet connection is not available 
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
