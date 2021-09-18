//
//  SLNetworkHelper.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 18/09/21.
//

import Foundation

public class SLNetworkHelper: NSObject {
    private let reachability = SLReachability()
    var shouldRefresh: Bool = false
    private static let _sharedInstance = SLNetworkHelper()
    
    @discardableResult
    public class func shared() -> SLNetworkHelper {
        return _sharedInstance
    }
    private override init () {
        super.init()
    }
}

public extension SLNetworkHelper {
    
    ///Network Functionalities
     func startReachabilityObserver() -> Void {
        guard let reachability = self.reachability else { return }
        reachability.startNotifier()
        
        reachability.onUnreachable = { reachability in
            print("network unreachable")
        }
        reachability.onReachable = { [weak self] reachability in
            guard let self = self else { return }
            self.handleRefreshAsset()
        }
    }
    
     func stopReachabilityObserver() -> Void {
        self.reachability?.stopNotifier()
    }
    
    private func handleRefreshAsset() {
        self.shouldRefresh = false
    }
    
    /// Public Method to check the network  status
    /// - Returns: Boolean
     func connectivityAvailable() -> Bool {
        guard let reachability = self.reachability else { return false}
        return reachability.isReachable
    }
}


