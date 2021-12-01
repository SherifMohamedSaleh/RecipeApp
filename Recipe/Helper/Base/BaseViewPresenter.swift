//
//  BaseViewPresenter.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//

import Foundation
protocol BaseViewProtocol {
    // hide and show no data view
    func showNoDataView(message : String)
    func hideNoDataView()
    // hide and show loading incicator
    func showLoadingView()
    func hideLoadingView()
    // show popup message
    func showMessage(message:String, type: MessageType)
}
class BaseViewPresenter : NSObject {
    
    private var connectivity : Connectivity = Connectivity.sharedConnectivityInstance
    
    override init() {
        super.init()
        initNetworkObserver()
    }
    
    func viewIsReady() {
        /// to be implemented withen each presenter
    }
    
    func initNetworkObserver() {
        connectivity.startNetworkReachabilityObserver { (status) in
            switch status {
            case .notReachable , .unknown :
                print("not reachable")
            case .reachable(.ethernetOrWiFi) , .reachable(.cellular):
                print("reachable")
            }
        }
    }
    
    func endNetworkObserver() {
        self.connectivity.reachability.stopListening()
    }
    
    deinit {
    //remove notification center for network
        self.endNetworkObserver()
    }
}
