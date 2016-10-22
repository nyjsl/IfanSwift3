//
//  HomeHeaderItemView.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class HomeHeaderItemView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.addSubview(bgImageView)
        self.addSubview(dateLabel)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.frame = self.bounds
    }
    
    var imageUrl: String?{
        didSet{
            if let url = imageUrl{
                self.bgImageView.extSetImage(URL(string: url))
            }
        }
    }
    
    var title: String!{
        didSet{
            titleLabel.text = title!
            let attributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 18)]
            let titleHeight = (title as NSString).boundingRect(with: CGSize(width: self.width-2*UIConstant.UI_MARGIN_10, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).height
            titleLabel.frame = CGRect(x: UIConstant.UI_MARGIN_10, y: self.height-50-titleHeight, width: self.width-2*UIConstant.UI_MARGIN_10, height: titleHeight)
            dateLabel.frame = CGRect(x: UIConstant.UI_MARGIN_10, y: titleLabel.y-25, width:self.width-2*UIConstant.UI_MARGIN_10, height: 20)
        }
    }
    
    var date: String!{
        didSet{
            dateLabel.text = date!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel: UILabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 18)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
    /// 分类和日期
    fileprivate lazy var dateLabel : UILabel = {
        var dateLabel: UILabel = UILabel()
        dateLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        dateLabel.textColor = UIColor.white
        return dateLabel
    }()
    
    /// 图片
    fileprivate lazy var bgImageView: UIImageView = {
        var bgImageView: UIImageView = UIImageView()
        bgImageView.contentMode = .scaleToFill
        return bgImageView
    }()

}
