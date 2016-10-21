//
//  HomeLatestTextCell.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/13.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
class HomeLatestTextCell: UITableViewCell,Reuseable{
    
    
    class func cellWithTableView(_ tableView: UITableView) -> HomeLatestTextCell{
        let cell = tableView.dequeReuseableCell() as HomeLatestTextCell?
        guard cell != nil else{
            return HomeLatestTextCell(style: .default, reuseIdentifier:HomeLatestTextCell.reuseIdentifier)
        }
        return cell!
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(authorImageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(likeLabel)
        self.contentView.addSubview(likeImageView)
        self.contentView.addSubview(introduceLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.layer.addSublayer(bottomLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var homePopbarLayout: HomePopbarLayout!{
        didSet{
            //设置图片位置
            authorImageView.frame = homePopbarLayout.kHomeCellAuthorImgRect
            //设置分类和时间
            let dateAttributedText = NSMutableAttributedString(string:
                "\(homePopbarLayout.model.category) | \(Date.getCommonExpresionOfDate(homePopbarLayout.model.pubDate))")
            dateAttributedText.addAttribute(NSForegroundColorAttributeName, value: UIConstant.UI_COLOR_RedTheme, range: NSRange(location: 0, length: 2))
            dateLabel.attributedText = dateAttributedText
            dateLabel.frame = homePopbarLayout.kHomeCellDateRect
            
            //喜欢数
            likeLabel.text = "\(homePopbarLayout.model.like)"
            likeLabel.frame = homePopbarLayout.kHomeCellLikeRect
            likeImageView.frame = homePopbarLayout.kHomeCellLikeImgRect
            
            //引文
            introduceLabel.attributedText =
                NSMutableAttributedString.attribute(homePopbarLayout.model.excerpt)
            introduceLabel.frame = homePopbarLayout.kHomeCellTextRect
            
            // 作者
            authorLabel.text = "—— \(homePopbarLayout.model.dasheng_author)"
            authorLabel.frame = homePopbarLayout.kHomeCellAuthorRect
            // 底部横线
            bottomLayer.frame = CGRect(x: UIConstant.UI_MARGIN_20, y: homePopbarLayout.cellHeight-1, width: self.width-2*UIConstant.UI_MARGIN_20, height: 1)
            
        }
    }
    //作者图片
    fileprivate lazy var authorImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_shudu")
        image.contentMode = .scaleAspectFit
        return image
    }()
    //分类和时间
    fileprivate lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIConstant.UI_COLOR_GrayTheme
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return label
    }()
    
    fileprivate lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIConstant.UI_COLOR_GrayTheme
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return label
    }()
    
    fileprivate lazy var likeImageView: UIImageView = {
        var likeImage = UIImageView(image: UIImage(named: "heart_selected_false"))
        likeImage.contentMode = .scaleAspectFit
        return likeImage
    }()
    
    /// 引文
    fileprivate lazy var introduceLabel: UILabel = {
        var introduceLabel = UILabel()
        introduceLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        introduceLabel.numberOfLines = 0
        introduceLabel.textColor = UIConstant.UI_COLOR_RedTheme
        return introduceLabel
    }()
    
    /// 作者
    fileprivate lazy var authorLabel: UILabel = {
        var authorLabel = UILabel()
        authorLabel.textAlignment = .center
        authorLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        authorLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        return authorLabel
    }()

    //底部分割线
    
    fileprivate lazy var bottomLayer: CALayer = {
        var bottom = CALayer()
        bottom.backgroundColor = UIConstant.UI_COLOR_GrayTheme.cgColor
        return bottom
    }()
    
}
