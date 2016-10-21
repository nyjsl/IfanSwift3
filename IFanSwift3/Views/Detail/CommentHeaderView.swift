//
//  CommentHeaderView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

protocol CommentHeaderDelegate {
    func gobackBtnDidClick()
    func timeSortedBtnDidClick(_ sender: UIButton)
    func heatSortedBtnDidClick(_ sender: UIButton)
}

class CommentHeaderView: UIView{
    
    fileprivate var model: CommonModel?
    
    var delegate: CommentHeaderDelegate?
    
    convenience init(model: CommonModel?){
        self.init()
        self.model = model
        
        self.topView.addSubview(self.goBackContainer)
        self.topView.addSubview(self.goBackBtn)
        self.topView.addSubview(self.titleLabel)
        self.bottomView.addSubview(hintLabel)
        self.bottomView.addSubview(self.timeSortedButton)
        self.bottomView.addSubview(self.line)
        self.bottomView.addSubview(self.heatSortedButton)
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        isUserInteractionEnabled = true
        timeSortedButton.isSelected = true
        
        setupLayout()
        
    }
    
    fileprivate func setupLayout(){
        self.topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(44)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.topView.snp.bottom)
            make.height.equalTo(40)
        }
        
        /// topView layout
        self.goBackContainer.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.width.equalTo(44)
        }
        self.goBackBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(15)
            make.top.equalTo(self.topView).offset(14.5)
            make.width.equalTo(17)
            make.height.equalTo(15)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.topView)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        /// bottomView layout
        self.hintLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.bottomView).offset(15)
            make.centerY.equalTo(self.bottomView)
        }
        self.timeSortedButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.hintLabel.snp.right).offset(5)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }
        self.line.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeSortedButton.snp.right).offset(3)
            make.top.equalTo(self.bottomView).offset(9)
            make.bottom.equalTo(self.bottomView).offset(-9)
            make.width.equalTo(1)
        }
        self.heatSortedButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.line.snp.right).offset(3)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }

    }
    
    @objc fileprivate func goBackBtnAction(){
        self.delegate?.gobackBtnDidClick()
    }
    
    @objc fileprivate func timeSrotedBtnAction(_ sender: UIButton){
        self.delegate?.timeSortedBtnDidClick(sender)
    }
    
    @objc fileprivate func heatSortBtnAction(_ sender: UIButton){
        self.delegate?.heatSortedBtnDidClick(sender)
    }
    
    
    //MARK Getter and Setter
    
    fileprivate lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.black
        return topView
    }()
    
    
    fileprivate lazy var goBackBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"ic_back"), for: UIControlState())
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goBackBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    /// goBackButton----
    fileprivate lazy var goBackContainer: UIButton = {
        let goBackContainer = UIButton()
        goBackContainer.addTarget(self, action: #selector(goBackBtnAction), for: .touchUpInside)
        return goBackContainer
    }()
    
    /// titleLabel
    fileprivate lazy var titleLabel: UILabel = {
        let titleLable: UILabel = UILabel()
        titleLable.text = "全部评论(0)"
        titleLable.font = UIFont.boldSystemFont(ofSize: 15)
        titleLable.textColor = UIColor.white
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    
    /// bottomView
    lazy var bottomView: UIView = {
        let bottomView: UIView = UIView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    
    /// 排序方式
    fileprivate lazy var hintLabel: UILabel = {
        let hintLabel: UILabel = UILabel()
        hintLabel.text = "排序方式:"
        hintLabel.textColor = UIColor.lightGray
        hintLabel.font = UIFont.systemFont(ofSize: 14)
        return hintLabel
    }()

    fileprivate lazy var timeSortedButton: UIButton = {
        let button = UIButton()
        button.setTitle("时间", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0), for: .selected)
        button.setTitleColor(UIColor.lightGray, for: UIControlState())
        button.addTarget(self, action: #selector(timeSrotedBtnAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var line: UIView = {
        let line: UIView = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    /// 热度排序
    fileprivate lazy var heatSortedButton: UIButton = {
        let heatSortedButton = UIButton()
        heatSortedButton.setTitle("热度", for: UIControlState())
        heatSortedButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        heatSortedButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        heatSortedButton.setTitleColor(UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0), for: .selected)
        heatSortedButton.addTarget(self, action: #selector(heatSortBtnAction), for: .touchUpInside)
        return heatSortedButton
    }()

    
    
}
