//
//  HomePopbarLayout.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

struct HomePopbarLayout: Initable{
    
    
    var model: CommonModel!
    
    let kHomeCellTopMargin = UIConstant.UI_MARGIN_20
    let kHomeCellPadding = UIConstant.UI_MARGIN_10
    let kHomeCellBottoMInset = UIConstant.UI_MARGIN_20
    
    
    var kHomeCellToolBarHeight: CGFloat = 15
    
    let authorSize: CGFloat = 30

    //图片Rect
    var kHomeCellPicRect: CGRect = CGRect.zero
    //标题Rect
    var kHomeCellTitleRect: CGRect = CGRect.zero

    //MARK: --------------------------- 没图片的Rect(大声) --------------------------
    var kHomeCellAuthorImgRect: CGRect = CGRect.zero
    var kHomeCellAuthorRect: CGRect = CGRect.zero
    
    //MARK: --------------------------- 数读 --------------------------
    var kHomeCellNumberRect: CGRect = CGRect.zero
    
    //MARK: --------------------------- 公共部分的Rect --------------------------
    /// 时间，分类Rect
    var kHomeCellDateRect: CGRect = CGRect.zero
    /// 喜欢数
    var kHomeCellLikeRect: CGRect = CGRect.zero
    var kHomeCellLikeImgRect: CGRect = CGRect.zero
    /// 引文Rect
    var kHomeCellTextRect: CGRect = CGRect.zero
    // 总高度
    var cellHeight: CGFloat = 0
    
    
    init(dict: NSDictionary) {
    }
    
    
    init(model: CommonModel){
        self.model = model
        if model.post_type == PostType.dasheng {
            self.setupTextLayout()
        } else if model.post_type == PostType.data {
            self.setupDataLayout()
        } else {
            self.setupPostLayout()
        }
    }
    
    fileprivate mutating func setupTextLayout(){
        
        let contentWidth = UIConstant.SCREEN_WIDTH-2*kHomeCellPadding
        
        // 作者头像
        self.kHomeCellAuthorImgRect = CGRect(x: kHomeCellPadding, y: 2*kHomeCellTopMargin, width: authorSize, height: authorSize)
        
        // 时间和分类
        let dateSize = calculateDateSize()
        self.kHomeCellDateRect = CGRect(x: kHomeCellAuthorImgRect.maxX+kHomeCellPadding, y: kHomeCellAuthorImgRect.minY, width: dateSize.width, height: kHomeCellToolBarHeight)
        
        // 喜欢
        let likeSize = calculateLikeSize()
        self.kHomeCellLikeRect = CGRect(x: UIConstant.SCREEN_WIDTH-kHomeCellPadding-likeSize.width, y: kHomeCellDateRect.minY, width: likeSize.width, height: kHomeCellToolBarHeight)
        self.kHomeCellLikeImgRect = CGRect(x: kHomeCellLikeRect.minX-kHomeCellPadding-kHomeCellToolBarHeight, y: kHomeCellDateRect.minY, width: kHomeCellToolBarHeight, height: kHomeCellToolBarHeight)
        
        // 引文。先分割出作者和内容
        let excerpAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 16)]
        let excerpWidth = UIConstant.SCREEN_WIDTH-kHomeCellDateRect.minX-kHomeCellPadding
        let excerptAndAuthor = model.excerpt.components(separatedBy: ":")
        let excerptSize = (excerptAndAuthor.last! as NSString).boundingRect(with: CGSize(width: excerpWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: excerpAttribute, context: nil).size
        self.kHomeCellTextRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellTopMargin+kHomeCellDateRect.maxY, width: excerptSize.width, height: excerptSize.height)
        
        // 作者
        let authorText = "—— \(excerptAndAuthor.first!)"
        let authorTextSize = (authorText as NSString).boundingRect(with: CGSize(width: contentWidth, height: 20), options: .usesLineFragmentOrigin, attributes: excerpAttribute, context: nil).size
        self.kHomeCellAuthorRect = CGRect(x: kHomeCellPadding, y: kHomeCellTextRect.maxY+kHomeCellTopMargin, width: contentWidth, height: authorTextSize.height)
        
        self.cellHeight = kHomeCellAuthorRect.maxY+2*kHomeCellBottoMInset
        
    }
    
    fileprivate mutating func setupPostLayout(){
        
        let cellPicWidth = UIConstant.SCREEN_WIDTH-2*kHomeCellPadding
        // 图片的Rect
        self.kHomeCellPicRect = CGRect(x: kHomeCellPadding, y: kHomeCellTopMargin, width: cellPicWidth, height: cellPicWidth*0.625)
        
        // 时间分类Rect
        
        let toolBarY = kHomeCellPicRect.maxY+kHomeCellPadding
        let dateSize = calculateDateSize()
        self.kHomeCellDateRect = CGRect(x: kHomeCellPadding, y: toolBarY, width: dateSize.width, height: kHomeCellToolBarHeight)
        
        // 喜欢数
        let likeSize = calculateLikeSize()
        self.kHomeCellLikeRect = CGRect(x: UIConstant.SCREEN_WIDTH-kHomeCellPadding-likeSize.width, y: toolBarY, width: likeSize.width, height: kHomeCellToolBarHeight)
        self.kHomeCellLikeImgRect = CGRect(x: kHomeCellLikeRect.minX-kHomeCellPadding-kHomeCellToolBarHeight, y: toolBarY, width: kHomeCellToolBarHeight, height: kHomeCellToolBarHeight)
        
        // 计算标题高度
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let titleAttributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 16), NSParagraphStyleAttributeName: paragraphStyle]
        let titleSize = (model.title as NSString).boundingRect(with: CGSize(width: cellPicWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil).size
        self.kHomeCellTitleRect = CGRect(x: kHomeCellPadding, y: kHomeCellLikeRect.maxY+kHomeCellPadding, width: titleSize.width, height: titleSize.height)
        
        // 计算引文高度
        let textAttributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12), NSParagraphStyleAttributeName: paragraphStyle]
        let textSize = (model.excerpt as NSString).boundingRect(with: CGSize(width: cellPicWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil).size
        self.kHomeCellTextRect = CGRect(x: kHomeCellPadding, y: kHomeCellTitleRect.maxY+kHomeCellPadding, width: textSize.width, height: textSize.height)
        
        // 总高度
        self.cellHeight = kHomeCellTextRect.maxY+kHomeCellBottoMInset
        
    }
    
    fileprivate mutating func setupDataLayout(){
        
        let contentWidth = UIConstant.SCREEN_WIDTH-2*kHomeCellPadding
        
        // 作者头像
        self.kHomeCellAuthorImgRect = CGRect(x: kHomeCellPadding, y: 2*kHomeCellTopMargin, width: authorSize, height: authorSize)
        
        // 时间和分类
        let dateSize = calculateDateSize()
        self.kHomeCellDateRect = CGRect(x: kHomeCellAuthorImgRect.maxX+kHomeCellPadding, y: kHomeCellAuthorImgRect.minY, width: dateSize.width, height: kHomeCellToolBarHeight)
        
        // 喜欢
        let likeSize = calculateLikeSize()
        self.kHomeCellLikeRect = CGRect(x: UIConstant.SCREEN_WIDTH-kHomeCellPadding-likeSize.width, y: kHomeCellDateRect.minY, width: likeSize.width, height: kHomeCellToolBarHeight)
        self.kHomeCellLikeImgRect = CGRect(x: kHomeCellLikeRect.minX-kHomeCellPadding-kHomeCellToolBarHeight, y: kHomeCellDateRect.minY, width: kHomeCellToolBarHeight, height: kHomeCellToolBarHeight)
        
        // 数字
        self.kHomeCellNumberRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellTopMargin+kHomeCellDateRect.maxY, width: contentWidth-2*kHomeCellDateRect.minX, height: 40)
        
        // 标题
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let titleAttributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 16), NSParagraphStyleAttributeName: paragraphStyle]
        let titleWidth = UIConstant.SCREEN_WIDTH-kHomeCellDateRect.minX-kHomeCellPadding
        let titleSize = (model.title as NSString).boundingRect(with: CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil).size
        self.kHomeCellTitleRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellNumberRect.maxY+kHomeCellTopMargin, width: titleWidth, height:titleSize.height)
        
        // 引文 去除<p></p>
        let excerpText = model.content.replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "")
        let excerpAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12)]
        let excerpSize = (excerpText as NSString).boundingRect(with: CGSize(width: titleWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: excerpAttribute, context: nil).size
        self.kHomeCellTextRect = CGRect(x: kHomeCellDateRect.minX, y: kHomeCellTopMargin+kHomeCellTitleRect.maxY, width: excerpSize.width, height: excerpSize.height)
        
        self.cellHeight = kHomeCellTextRect.maxY+2*kHomeCellBottoMInset

        
    }
    
    fileprivate func calculateDateSize() -> CGSize{
        let dateStr = "\(model.category!) | \(Date.getDate(model.pubDate)))"
        let toolbarAttribute = [NSFontAttributeName:UIFont.customFont_FZLTXIHJW(fontSize: 12)]
        return (dateStr as NSString).boundingRect(with: CGSize(width: 200, height: kHomeCellToolBarHeight), options: .usesLineFragmentOrigin, attributes: toolbarAttribute, context: nil).size

    }
    
    /**
     计算喜欢数
     */
    fileprivate func calculateLikeSize() -> CGSize {
        let likeAttribute = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 12)]
        return ("\(model.like!)" as NSString).boundingRect(with: CGSize(width: 100, height: kHomeCellToolBarHeight), options: .usesLineFragmentOrigin, attributes: likeAttribute, context: nil).size
    }

    
}
