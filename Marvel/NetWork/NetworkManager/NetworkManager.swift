//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Daniel Personal on 3/12/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let reachabilityManager =  try? Reachability()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachabilityManager?.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachabilityManager?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func checkNetwork() -> Bool {
        return self.reachabilityManager?.connection != .unavailable
    }
}
