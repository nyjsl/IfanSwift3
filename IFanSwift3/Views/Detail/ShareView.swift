//
//  ShareView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//


import Foundation
import UIKit

public protocol ShareViewDelegate: class{
    
    func wxShareBtnDidClick()
    func wxCircleShareBtnDidClick()
    func shareMoreBtnDidClick()
    
}

open class ShareView: UIView{
    
    var delegate: ShareViewDelegate?
    
    //MARK -life cycle--
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.wxShareBtn)
        self.addSubview(self.wxCircleShareBtn)
        self.addSubview(self.shareMoreButton)
        self.addSubview(self.logoShareImageView)
        self.addSubview(titleLabel)
        self.addSubview(wxShareLabel)
        self.addSubview(shareMoreLabel)
        self.addSubview(wxCircleShareLabel)
        self.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        self.setupLayout()

    }
    
    fileprivate func setupLayout(){
        logoShareImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(20)
            make.height.width.equalTo(13)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoShareImageView.snp.right).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerY.equalTo(logoShareImageView)
        }
        wxShareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(logoShareImageView.snp.bottom).offset(30)
            make.left.equalTo(self).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        wxCircleShareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(logoShareImageView.snp.bottom).offset(30)
            make.centerX.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        shareMoreButton.snp.makeConstraints { (make) in
            make.top.equalTo(logoShareImageView.snp.bottom).offset(30)
            make.right.equalTo(self).offset(-30)
            make.width.height.equalTo(50)
        }
        
        wxShareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wxShareBtn.snp.bottom).offset(10)
            make.centerX.equalTo(wxShareBtn)
            make.width.equalTo(150)
        }
        
        wxCircleShareLabel.snp.makeConstraints { (make) in
            make.top.equalTo(wxCircleShareBtn.snp.bottom).offset(10)
            make.centerX.equalTo(wxCircleShareBtn)
            make.width.equalTo(150)
        }
        
        shareMoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(shareMoreButton.snp.bottom).offset(10)
            make.centerX.equalTo(shareMoreButton)
            make.width.equalTo(150)
        }

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK ACTION
    func wxShareAction(){
        self.delegate?.wxShareBtnDidClick()
    }
    
    func wxCirCleAction(){
        self.delegate?.wxCircleShareBtnDidClick()
    }
    
    func shareMoreAction(){
        self.delegate?.shareMoreBtnDidClick()
    }
    
    //MARK Setter Getter
    fileprivate lazy var wxShareBtn: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "share_wechat"), for: UIControlState())
        button.setTitle("微信朋友", for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(wxShareAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var wxShareLabel: UILabel = {
        let label = UILabel()
        label.text = "微信朋友"
        label.textAlignment = .center
        label.textColor = UIColor(red: 82/255.0, green: 78/255.0, blue: 80/255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    fileprivate lazy var wxCircleShareBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share_wechat_moment"), for: UIControlState())
        button.setTitle("朋友圈", for: UIControlState())
        button.addTarget(self, action: #selector(wxCirCleAction), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate lazy var wxCircleShareLabel: UILabel = {
        let label = UILabel()
        label.text = "朋友圈"
        label.textAlignment = .center
        label.textColor = UIColor(red: 82/255.0, green: 78/255.0, blue: 80/255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // 分享更多
    fileprivate lazy var shareMoreButton: UIButton = {
        let shareMoreButton = UIButton()
        shareMoreButton.setImage(UIImage(named: "share_more"), for: UIControlState())
        shareMoreButton.setTitle("更多", for: UIControlState())
        shareMoreButton.addTarget(self, action: #selector(shareMoreAction), for: .touchUpInside)
        
        return shareMoreButton
    }()
    fileprivate lazy var shareMoreLabel: UILabel = {
        let shareMoreLabel = UILabel()
        shareMoreLabel.text = "更多"
        shareMoreLabel.textAlignment = .center
        shareMoreLabel.textColor = UIColor(red: 82/255.0, green: 78/255.0, blue: 80/255.0, alpha: 1.0)
        shareMoreLabel.font = UIFont.systemFont(ofSize: 13)
        
        return shareMoreLabel
    }()

    // logo
    fileprivate lazy var logoShareImageView: UIImageView = {
        let logoShareImageView = UIImageView()
        logoShareImageView.image = UIImage(named: "ic_dialog_share")
        
        return logoShareImageView
    }()
    // titleLabel
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "分享文章给朋友:"
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        titleLabel.textColor = UIColor(red: 124/255.0, green: 129/255.0, blue: 142/255.0, alpha: 1.0)
        
        return titleLabel
    }()

    
}
