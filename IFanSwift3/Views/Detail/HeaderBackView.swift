//
//  HeaderBackView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol HeaderViewDelegate {
    func backButtonDidClick()
}

class HeaderBackView: UIView{
    
    var delegate: HeaderViewDelegate?
    
    var title: String! = "" {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
        backgroundColor = UIColor.clear
        addSubview(blurView)
        addSubview(backButton)
        addSubview(titleLabel)
        setUpLayout()
        
    }
    
    fileprivate func setUpLayout(){
        blurView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        backButton.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.backButton.snp_right)
            make.centerY.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
    }
    
    //MARK  ------ACTION EVENT------
    @objc fileprivate func goBack(){
        self.delegate?.backButtonDidClick()
    }
    
    //MARK  -----------getter and setter-----
    
    fileprivate lazy var backButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(imageLiteral: "ic_article_back"), for: UIControlState())
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.font = UIFont.customFont_FZLTZCHJW(fontSize: 14)
        return label
    }()
    
    fileprivate lazy var blurView: UIVisualEffectView = {
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
}
