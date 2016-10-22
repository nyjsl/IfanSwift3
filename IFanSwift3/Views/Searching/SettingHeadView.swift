//
//  SettingHeadView.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class SettingHeadView: UIView{
    
    typealias BackBtnClickCallback = () -> Void
    
    var callBack: BackBtnClickCallback?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(titleLabel)
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.size.equalTo(CGSize(width: 50, height: 15))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(20)
        }

        
    }
    
    func registerCallBack(_ callBack:  BackBtnClickCallback?){
        self.callBack = callBack
    }
    
    @objc private func backBtnAction(){
        if let cl = callBack{
            cl()
        }
    }
    
    private lazy var backBtn: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "ic_back"), for: UIControlState())
        button.addTarget(self, action: #selector(SettingHeadView.backBtnAction), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "设置"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 16)
        return titleLabel
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
