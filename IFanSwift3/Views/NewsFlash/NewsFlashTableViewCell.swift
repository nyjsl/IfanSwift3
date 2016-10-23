//
//  NewsFlashTableViewCell.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/23.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
class NewsFlashTableViewCell: UITableViewCell,Reuseable{
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(pointView)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(contentLable)
        self.contentView.addSubview(sourceLabel)
        
        self.setUpLayout()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpLayout() {
        
        self.pointView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_12)
            make.top.equalTo(self).offset(20)
            make.height.width.equalTo(8)
        }
        
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(pointView.snp.right).offset(UIConstant.UI_MARGIN_12)
            make.right.equalTo(self).offset(32)
            make.centerY.equalTo(self.pointView)
            make.height.equalTo(20)
        }
        
        self.contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(32)
            make.right.equalTo(self).offset(-32)
            make.top.equalTo(self.timeLabel.snp.bottom).offset(5)
            make.bottom.equalTo(self.sourceLabel.snp.top).offset(-5)
        }
        
        self.sourceLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).offset(32)
            make.bottom.equalTo(self).offset(-15)
            make.height.equalTo(20)
        }
        
        self.pointView.layer.cornerRadius = 4
        self.pointView.backgroundColor = UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0)
    }

    // 计算内容的高度
    class func estimateCellHeight(_ content : String) -> CGFloat {
        let size = CGSize(width: UIConstant.SCREEN_WIDTH - 64 ,height: 2000)
        
        let attrs = NSMutableAttributedString(string: content)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : UIFont.customFont_FZLTXIHJW(fontSize: 16),
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]
        
        
        attrs.addAttribute(NSFontAttributeName,
                           value: UIFont.customFont_FZLTXIHJW(fontSize: 16),
                           range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSParagraphStyleAttributeName, value: paragphStyle, range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSKernAttributeName, value: 1.0, range: NSMakeRange(0, (content.characters.count)))
        
        let labelRect : CGRect = content.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        // 50为其他控件的高度
        return labelRect.height + 50;
    }

    //MARK:-----Private Function----
    class func cellWithTableView(_ tableView : UITableView) -> NewsFlashTableViewCell {
        var cell: NewsFlashTableViewCell? = tableView.dequeReuseableCell() as NewsFlashTableViewCell?
        if cell == nil {
            cell = NewsFlashTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }

    
    var model: CommonModel!{
        didSet{
            
            self.timeLabel.text = Date.getCommonExpresionOfDate(model.pubDate!)
            let attrs = NSMutableAttributedString(string: model.title!)
            let paragraphStyle = NSMutableParagraphStyle()
            attrs.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, model.title!.characters.count))
            self.contentLable.attributedText = attrs
            self.sourceLabel.text   = "来源：" + (model.excerpt?.components(separatedBy: "/")[2])!

        }
    }
    
    fileprivate lazy var timeLabel : UILabel = {
        //时间
        let timeLabel   = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        timeLabel.font  = UIFont.customFont_FZLTXIHJW(fontSize: 13)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel;
        
    }()
    
    fileprivate lazy var pointView : UIView = {
        //小红点
        let pointView    = UIView()
        
        return pointView;
    }()
    
    
    fileprivate lazy var contentLable : UILabel = {
        let contentLable = UILabel()
        contentLable.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        contentLable.numberOfLines = 0
        contentLable.lineBreakMode = .byWordWrapping
        return contentLable
    }()
    
    fileprivate lazy var sourceLabel : UILabel = {
        let sourceLabel = UILabel()
        sourceLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        sourceLabel.textColor = UIColor.lightGray
        return sourceLabel
    }()

    
}
