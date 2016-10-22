//
//  MenuHeaderView.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

protocol MenuHeaderViewDelegate {
    func searchBtnDidClick(_ headerView: MenuHeaderView,searchBtn: UIButton)
    func settingBtnDidClkci(_ headerView: MenuHeaderView,settingBtn: UIButton)
}

class MenuHeaderView: UIView{
    
    var delegate: MenuHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImg)
        addSubview(searchBtn)
        addSubview(settingBtn)
        
        logoImg.snp.makeConstraints { [unowned self](make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.height.equalTo(30)
            make.width.equalTo(187/48*30)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        settingBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.centerY.equalTo(self.logoImg)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        searchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.settingBtn.snp.left).offset(-30)
            make.top.equalTo(self.settingBtn)
            make.size.equalTo(settingBtn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func searchBtnAction(){
        self.delegate?.searchBtnDidClick(self, searchBtn: searchBtn)
    }
    
    @objc private func settingBtnAction(){
        self.delegate?.settingBtnDidClkci(self, settingBtn: settingBtn)
    }
    
    private lazy var logoImg: UIImageView = {
        var logImg: UIImageView = UIImageView(image: UIImage(named: "ic_profile_logo"))
        logImg.contentMode = .scaleAspectFit
        return logImg
    }()
    
    private lazy var searchBtn: UIButton = {
        var btn: UIButton = UIButton()
        btn.addTarget(self, action: #selector(MenuHeaderView.searchBtnAction), for: .touchUpInside)
        btn.setImage(UIImage(named: "ic_search"), for: UIControlState())
        return btn
    }()
    private lazy var settingBtn: UIButton = {
        var btn: UIButton = UIButton()
        btn.addTarget(self, action: #selector(MenuHeaderView.settingBtnAction), for: .touchUpInside)
        btn.setImage(UIImage(named: "ic_setting"), for: UIControlState())
        return btn
    }()

    
}
