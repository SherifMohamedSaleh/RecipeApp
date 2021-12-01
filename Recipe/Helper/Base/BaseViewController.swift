//
//  BaseViewController.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//


import UIKit
import MBProgressHUD
import SwiftMessages

class BaseViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate , UIDocumentInteractionControllerDelegate {
    
    private lazy var noDataView : NoDataView = {
        let view = NoDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var presenter : BaseViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
 
    
    @objc dynamic  func showNoDataView (message : String){
        self.view.addSubview(noDataView)
        self.installNoDataViewLayoutConstraints()
        noDataView.setUpData(noDataText : message)
        noDataView.isHidden = false
    }
    
    
    @objc dynamic func  hideNoDataView (){
        noDataView.isHidden = true
    }
    
    

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func installNoDataViewLayoutConstraints(){
        //Setting constraints for no data view
        NSLayoutConstraint.activate([noDataView.topAnchor.constraint(equalTo: self.view.topAnchor), noDataView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),noDataView.leftAnchor.constraint(equalTo: self.view.leftAnchor),noDataView.rightAnchor.constraint(equalTo: self.view.rightAnchor)])
    }
    

    @objc dynamic func showLoadingView () {
        self.hideLoadingView()
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = false
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
        
    }
    
    @objc dynamic func hideLoadingView (){
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showMessage(message:String, type: MessageType){
        DispatchQueue.main.async {
            Utilities.showPopup(message: message, type: type  ,firstButtonTitle: "Okay" , firstButtonAction: nil ,secondButtonTitle: nil, secondButtonAction: nil)
        }
    }
    

}
