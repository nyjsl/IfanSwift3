//
//  TableHeaderView.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/23.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class TableHeaderView: UIView{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(backgroundImage)
        self.addSubview(titleLabel)
        self.addSubview(detailTitleLabel)
        self.addSubview(tagImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(model: TableHeaderModel) {
        self.init(frame:CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 100 * UIConstant.SCREEN_HEIGHT / UIConstant.IPHONE5_HEIGHT))
        self.backgroundImage.image = model.backImage
        self.titleLabel.text = model.title
        self.detailTitleLabel.text = model.detail
        self.tagImageView.image = model.tagImage

    }
    
    fileprivate lazy var backgroundImage: UIImageView = {
        let backgroundImg: UIImageView = UIImageView(frame: CGRect(x: 0, y: -1, width: self.width, height: 80 * UIConstant.SCREEN_HEIGHT/UIConstant.IPHONE5_HEIGHT))
        backgroundImg.backgroundColor = UIColor.black
        backgroundImg.contentMode = .scaleAspectFill
        return backgroundImg
    }()
    
    /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel(frame: CGRect(x: 20, y: 10, width: self.width, height: 40))
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 22)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
    /// 副标题
    fileprivate lazy var detailTitleLabel: UILabel = {
        let detailTitleLabel    = UILabel(frame: CGRect(x: 20, y: self.titleLabel.bottom, width: self.width, height: 30))
        detailTitleLabel.font   = UIFont.customFont_FZLTZCHJW(fontSize: 14)
        detailTitleLabel.textColor = UIColor.white
        return detailTitleLabel
    }()
    
    /// 底部图片
    fileprivate lazy var tagImageView: UIImageView = {
        let tagImageView = UIImageView(frame: CGRect(x: 0, y: self.backgroundImage.bottom - 5, width: UIConstant.SCREEN_WIDTH, height: 25))
        
        tagImageView.contentMode = UIViewContentMode.scaleAspectFit
        return tagImageView
    }()

    
}
