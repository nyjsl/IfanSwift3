//
//  PlayingZhiTableViewCell.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/26.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class PlayingZhiTableViewCell: UITableViewCell,Reuseable{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.likeCountLabel)
        self.contentView.addSubview(self.heartImgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.infoLabel)
        self.contentView.addSubview(self.separateLineView)
        
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: CommonModel!{
        didSet{
            self.timeLabel.text = Date.getCommonExpresionOfDate((model.pubDate!))
            self.likeCountLabel.text    = "\(model.like!)"
            self.titleLabel.attributedText = UILabel.setAttrubutedText(model.title!, lineSpacing: 5.0)
            self.infoLabel.attributedText  = UILabel.setAttrubutedText(model.excerpt!, lineSpacing: 5.0)
            self.logoImageView.extSetImage(URL(string: model.image!))
        }
    }
    
    func setupLayout(){
        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self).offset(-1 * UIConstant.UI_MARGIN_15)
            make.height.equalTo(170).priority(1000)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(UIConstant.UI_MARGIN_10)
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        self.likeCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.timeLabel)
            make.right.equalTo(self).offset(-1 * UIConstant.UI_MARGIN_15)
            make.width.height.equalTo(20)
        }
        self.heartImgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.likeCountLabel.snp.left).offset(-UIConstant.UI_MARGIN_5)
            make.centerY.equalTo(self.timeLabel)
            make.width.height.equalTo(10)
        }
        self.separateLineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-UIConstant.UI_MARGIN_5)
            make.centerX.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(2)
        }
        self.infoLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.separateLineView.snp.top).offset(-UIConstant.UI_MARGIN_10)
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self).offset(-1 * UIConstant.UI_MARGIN_15)
            make.height.equalTo(50)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_15)
            make.right.equalTo(self).offset(-UIConstant.UI_MARGIN_15)
            make.bottom.equalTo(self.infoLabel.snp.top)
            make.top.equalTo(self.likeCountLabel.snp.bottom)
        }

    }
    
    class func cellViewTableView(tableView: UITableView) -> PlayingZhiTableViewCell{
        var cell = tableView.dequeReuseableCell() as PlayingZhiTableViewCell?
        if cell == nil{
            cell = PlayingZhiTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    //MARK:-----setter or getter-----
    // 封面
    fileprivate lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    // 时间
    fileprivate lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    // 点赞的数目
    fileprivate lazy var likeCountLabel: UILabel = {
        let likeCountLabel = UILabel()
        likeCountLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        likeCountLabel.textColor = UIColor.lightGray
        return likeCountLabel
    }()
    //点赞左侧的心
    fileprivate lazy var heartImgView: UIImageView = {
        let heartImgView = UIImageView()
        heartImgView.image = #imageLiteral(resourceName: "heart_selected_false")
        return heartImgView
    }()
    // 标题，需动态计算高度
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 16)
        titleLabel.numberOfLines    = 0
        titleLabel.lineBreakMode    = .byWordWrapping
        return titleLabel
    }()
    // 粗略信息，固定两行
    fileprivate lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.numberOfLines     = 0
        infoLabel.lineBreakMode     = .byCharWrapping
        infoLabel.font      = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        infoLabel.textColor = UIColor.lightGray
        return infoLabel
    }()
    // 小黄线
    fileprivate lazy var separateLineView: UIView = {
        let separateLineView = UIView()
        separateLineView.backgroundColor = UIColor.brown
        return separateLineView
    }()
    
    // 计算内容的高度
    class func estimateCellHeight(_ content : String) -> CGFloat {
        let size = CGSize(width: UIConstant.SCREEN_WIDTH - 30 ,height: 2000)
        
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : UIFont.customFont_FZLTXIHJW(fontSize: 16),
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]
        
        let labelRect : CGRect = content.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as [String : AnyObject], context: nil)
        
        // 50为其他控件的高度
        return labelRect.height + 280;
    }


}
