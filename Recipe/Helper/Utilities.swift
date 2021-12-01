//
//  Utilities.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//

import Foundation
import SwiftMessages

class Utilities: NSObject {
  
  class func showPopup(message: String, type: MessageType , direction:ActionsDirections = .Horizontal , firstButtonTitle:String , firstButtonAction:(()-> Void)?, secondButtonTitle:String? , secondButtonAction:(()-> Void)? , secondButtonColor:UIColor = .red){
    let popUpView: PopupView = try! SwiftMessages.viewFromNib()
    
    popUpView.message = message
    popUpView.messageType = type
    
    popUpView.buttonFirstTitle = firstButtonTitle
    popUpView.buttonSecondTitle = secondButtonTitle
    popUpView.userPressedOnFirstButton =  firstButtonAction
    popUpView.userPressedOnSecondButton = secondButtonAction
    popUpView.actionDirection = direction
    popUpView.secondButtonBackgroundColor = secondButtonColor

    showPopUpForView(view: popUpView)
    }
    
    class func showPopUpForView(view: UIView){
        
      var config = SwiftMessages.defaultConfig
      config.presentationStyle = .center
      config.presentationContext = .automatic
      config.duration = .forever
      config.dimMode = .gray(interactive: false)
      config.interactiveHide = false

      SwiftMessages.show(config: config, view: view)
    }
}
