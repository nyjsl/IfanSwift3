//
//  HomePageController.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class HomePageController: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var currentPage: Int!{
        didSet{
            self.setUpPage(currentPage)
        }
    }
    
    var numberOfPage: Int!{
        didSet{
            pageArray.forEach {
                $0.removeFromSuperview()
            }
            for page in 0..<numberOfPage{
                let pageLabel = buildPageLabel()
                pageLabel.frame = CGRect(x: CGFloat(page)*(UIConstant.UI_MARGIN_10+self.height), y: 0, width: self.height, height: self.height)
                self.addSubview(pageLabel)
                pageArray.append(pageLabel)
            }
            
            self.currentPage = 0
        }
    }
    
    var lastPageLable: UILabel?
    
    private func setUpPage(_ index: Int){
        if let label = lastPageLable{
            label.text = ""
            label.backgroundColor = UIColor.clear
        }
        
        let currentLabel = pageArray[index]
        currentLabel.backgroundColor = UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1)
        currentLabel.text = "\(index+1)"
        self.lastPageLable = currentLabel
    }
    
    private func buildPageLabel() -> UILabel{
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.font = UIConstant.UI_FONT_12
        label.alpha = 0.8
        label.layer.borderColor = UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1).cgColor
        label.layer.borderWidth = 1
        return label
    }
    
    
    convenience init(frame: CGRect,numberOfPage: Int = 0) {
        self.init(frame: frame)
        self.numberOfPage = numberOfPage
        self.currentPage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var pageArray: [UILabel]! = []
    
    

}
