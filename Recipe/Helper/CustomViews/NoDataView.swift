//
//  NoDataView.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//


import Foundation
import  UIKit

class NoDataView : UIView {
    
    @IBOutlet weak var lbl_NoDataViewDescribtion: UILabel!
    @IBOutlet weak var contentView: UIView!
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setupView()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    func setupView(){
        contentView = loadViewFromNib()
        contentView.frame = bounds
        self.addSubview(contentView)
    }
    
    func setUpData(noDataText : String){
        lbl_NoDataViewDescribtion.text = noDataText
    }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NoDataView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}

