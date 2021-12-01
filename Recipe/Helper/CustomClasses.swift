//
//  CustomClasses.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//


import Foundation
import UIKit

@IBDesignable
class CurvedScrollView: UIScrollView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

@IBDesignable
class CurvedShadowScrollView: UIScrollView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
    }
    
}

@IBDesignable
class CurvedShadowView: UIView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var cornerRadiusBottomOnly: Bool  {
        get {
            return self.layer.masksToBounds
        }
        set {
            if newValue == true {
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                self.gradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
    
    @IBInspectable var cornerRadiusTopOnly: Bool  {
        get {
            return self.layer.masksToBounds
        }
        set {
            if newValue == true {
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                self.gradientLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor,bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            gradientLayer.startPoint = CGPoint(x:0.0, y:0.0);
            gradientLayer.endPoint = CGPoint(x:1.0,y: 0.0);
          layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
    
    @IBInspectable var shadowBottomOnly: Bool = false  {
        didSet{
            if shadowBottomOnly{
                self.layer.shadowOpacity = 0.1
                self.layer.shadowOffset = CGSize(width: 0 , height:6)
            }
        }
    }
}

@IBDesignable
class RoundedView: UIView {
    
     
      @IBInspectable var cornerRadius: CGFloat {
          get {
              return self.layer.cornerRadius
          }
          set {
              self.layer.cornerRadius = newValue
          }
      }
    
    @IBInspectable var cornerRadiusBottomOnly: Bool  {
        get {
            return self.layer.masksToBounds
        }
        set {
            if newValue == true {
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                //self.gradientLayer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
    
    @IBInspectable var cornerRadiusTopOnly: Bool  {
        get {
            return self.layer.masksToBounds
        }
        set {
            if newValue == true {
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                //self.gradientLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    @IBInspectable var BorderWidth: CGFloat  {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var BorderColor: UIColor?  {
        didSet {
            self.layer.borderColor = BorderColor?.cgColor
        }
    }
      
}

@IBDesignable
class RoundedImageView: UIImageView {
    
     
      @IBInspectable var cornerRadius: CGFloat {
          get {
              return self.layer.cornerRadius
          }
          set {
              self.layer.cornerRadius = newValue
          }
      }
      
}

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth: CGFloat{
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        get{
            let color = UIColor(cgColor: self.layer.borderColor!)
            return color
        }
        
        set{
            self.layer.borderColor = newValue?.cgColor
        }
    }

}

@IBDesignable
class CircleButton: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}

@IBDesignable
class CircularImageView: UIImageView {

    private weak var borderLayer: CAShapeLayer?
    private let frameLayer = CAShapeLayer()

 
  
    override func layoutSubviews() {
        super.layoutSubviews()

        // create path

        let width = min(bounds.width, bounds.height)
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: width / 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)

        // update mask and save for future reference

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask

        // create border layer

        frameLayer.path = path.cgPath
        frameLayer.strokeColor = UIColor.white.cgColor
        frameLayer.fillColor = nil

        // if we had previous border remove it, add new one, and save reference to new one

        borderLayer?.removeFromSuperlayer()
        layer.addSublayer(frameLayer)
        borderLayer = frameLayer
    }
  
  @IBInspectable
  var lineWidth: CGFloat = 0.0 {
          didSet {
            frameLayer.lineWidth = lineWidth
          }
      }
}


extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}


class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
