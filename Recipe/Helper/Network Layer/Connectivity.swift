//
//  Connectivity.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//


import Foundation
import Alamofire
import UIKit

class Connectivity : NSObject {
    
    static let sharedConnectivityInstance : Connectivity = {
        return Connectivity()
    }()
    
    var reachability: NetworkReachabilityManager!
    
    override init() {
        super.init()
        // Initialise reachability
        reachability = NetworkReachabilityManager()
    }
    
    // Network observable
    func startNetworkReachabilityObserver(completed: @escaping (NetworkReachabilityManager.NetworkReachabilityStatus) -> Void) {
        reachability.startListening { status in
            completed(status)
        }
    }
}

