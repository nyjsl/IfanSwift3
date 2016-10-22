//
//  HomeLatestImageCell.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/13.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class HomeLatestImageCell: UITableViewCell,Reuseable {
    
    class func cellWithTableView(_ tableView: UITableView) -> HomeLatestImageCell{
        let cell = tableView.dequeReuseableCell() as HomeLatestImageCell?
        guard cell != nil else{
            return HomeLatestImageCell(style: .default, reuseIdentifier:HomeLatestImageCell.reuseIdentifier)
        }
        return cell!
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.contentView.addSubview(linkImageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(likeLabel)
        self.contentView.addSubview(likeImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(introduceLabel)
        self.layer.addSublayer(cellBottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 给外部传入一个layout
    var popularLayout: HomePopbarLayout! {
        didSet {
            // 设置图片位置
            linkImageView.extSetImage(URL(string: popularLayout.model.image))
            linkImageView.frame = popularLayout.kHomeCellPicRect
            
            // 设置分类和时间
            let dateAttributeText = NSMutableAttributedString(string: "\(popularLayout.model.category!) | \(Date.getCommonExpresionOfDate(popularLayout.model.pubDate))")
            dateAttributeText.addAttribute(NSForegroundColorAttributeName, value: UIConstant.UI_COLOR_RedTheme, range: NSRange(location: 0, length: 2))
            dateLabel.attributedText = dateAttributeText
            dateLabel.frame = popularLayout.kHomeCellDateRect
            
            // 喜欢数
            likeLabel.text = "\(popularLayout.model.like!)"
            likeLabel.frame = popularLayout.kHomeCellLikeRect
            likeImageView.frame = popularLayout.kHomeCellLikeImgRect
            
            // 标题
            titleLabel.attributedText = NSMutableAttributedString.attribute(popularLayout.model.title)
            titleLabel.frame = popularLayout.kHomeCellTitleRect
            
            // 引文
            introduceLabel.attributedText = NSMutableAttributedString.attribute(popularLayout.model.excerpt)
            introduceLabel.frame = popularLayout.kHomeCellTextRect
            
            // 底部横线
            cellBottomLine.frame = CGRect(x: self.width*0.5-10, y: popularLayout.cellHeight-2, width: 20, height: 2)
        }
    }
    
    
    //MARK: --------------------------- Getter and Setter --------------------------
    ///  图片
    fileprivate lazy var linkImageView: UIImageView = {
        var linkImageView: UIImageView = UIImageView()
        linkImageView.contentMode = .scaleToFill
        return linkImageView
    }()
    
    /// 分类 和 时间
    fileprivate lazy var dateLabel: UILabel = {
        var dateLabel = UILabel()
        dateLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        dateLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return dateLabel
    }()
    
    /// 喜欢数
    fileprivate lazy var likeLabel: UILabel = {
        var likeLabel = UILabel()
        likeLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        likeLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return likeLabel
    }()
    
    fileprivate lazy var likeImageView: UIImageView = {
        var likeImage = UIImageView(image: UIImage(named: "heart_selected_false"))
        likeImage.contentMode = .scaleAspectFit
        return likeImage
    }()
    /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    /// 引文
    fileprivate lazy var introduceLabel: UILabel = {
        var introduceLabel = UILabel()
        introduceLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        introduceLabel.numberOfLines = 0
        introduceLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        return introduceLabel
    }()
    
    /// 底部分割线
    fileprivate lazy var cellBottomLine: CALayer = {
        var cellBottomLine = CALayer()
        cellBottomLine.backgroundColor = UIConstant.UI_COLOR_GrayTheme.cgColor
        return cellBottomLine
    }()


}
