//
//  PopupView.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//

import UIKit
import SwiftMessages

enum MessageType : String {
  case Info  = "info"
  case Sad   = "sadIcon"
}

enum ActionsDirections : Int {
  case Horizontal  = 0
  case Vertical    = 1
}

class PopupView: MessageView {
  
  @IBOutlet weak private var stackView: UIStackView!
  @IBOutlet weak private var iv_Icon: UIImageView!
  @IBOutlet weak private var lb_Message: UILabel!
  @IBOutlet weak  var btn_One: UIButton!
  @IBOutlet weak  var btn_Two: UIButton!
  
  var userPressedOnFirstButton :(()-> Void)?
  var userPressedOnSecondButton :(()-> Void)?
  var secondButtonBackgroundColor : UIColor = .red {
    didSet{
      btn_Two.backgroundColor = secondButtonBackgroundColor
    }
  }
  var actionDirection:ActionsDirections = .Horizontal {
    didSet{
      
      switch actionDirection {
        
      case .Horizontal:
        stackView.axis = .horizontal
      case .Vertical:
        stackView.axis = .vertical
      }
    }
  }
  
  var messageType:MessageType = .Info {
    didSet{
      iv_Icon.image = UIImage.init(named: messageType.rawValue)
    }
  }
  
  var buttonFirstTitle :String? {
    didSet {
      if buttonFirstTitle != nil {
        
        btn_One.setTitle(buttonFirstTitle, for: .normal)
        btn_One.isHidden = false
        btn_One.layoutIfNeeded()
        
      }
      else{
        btn_One.isHidden = true
        btn_One.layoutIfNeeded()
        
      }
    }
  }
  var buttonSecondTitle :String? {
    didSet {
      if buttonSecondTitle != nil {
        btn_Two.setTitle(buttonSecondTitle, for: .normal)
        btn_Two.isHidden = false
        btn_Two.layoutIfNeeded()
        
      }
      else{
        btn_Two.isHidden = true
        btn_Two.layoutIfNeeded()
      }
    }
  }
  var message :String? {
    didSet {
      lb_Message.text = message
    }
  }
  
  
  override func awakeFromNib() {
  }
  
  @IBAction func userPressedOnRightButton (_ sender: Any) {
    SwiftMessages.hide()
    
    userPressedOnSecondButton?()
  }
  
  @IBAction func userPressedOnLeftButton (_ sender: Any) {
    SwiftMessages.hide()
    
    userPressedOnFirstButton?()
  }
}
