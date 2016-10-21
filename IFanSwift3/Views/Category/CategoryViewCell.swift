//
//  CategoryViewCell.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/9.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CategrotyViewCell: UICollectionViewCell,Reuseable{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(menuImageView)
        self.contentView.addSubview(coverView)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
        
        setLayout()

    }
    
    fileprivate func setLayout(){
        menuImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        coverView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        iconImageView.snp_makeConstraints { (make) in
            make.right.bottom.equalTo(self.contentView).inset(UIConstant.UI_MARGIN_5)
            make.size.equalTo(15)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self.contentView).offset(UIConstant.UI_MARGIN_5)
            make.height.equalTo(20)
        }
    }
    
    var model: CategoryModel!{
        didSet{
            self.menuImageView.image = model.backgroudImage
            self.coverView.backgroundColor = model.coverColor
            self.iconImageView.image = model.icon
            self.titleLabel.text = model.title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //背景图
    fileprivate lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //alpha
    fileprivate lazy var coverView: UIView = {
        let cover = UIView()
        return cover
    }()
    
    // 右下角图片
    fileprivate lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        return iconImageView
    }()
    
    // 标题
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return titleLabel
    }()
    
}

class CategoryHeaderView: UICollectionReusableView,Reuseable{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(image: UIImage(named: "tag_more_columns" ))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: self.width, height: 25)
        imageView.center = CGPoint(x: self.center.x, y: fabs(self.center.y))
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


