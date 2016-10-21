//
//  CommentTableViewCell.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class CommentTableViewCell: UITableViewCell,Reuseable{
    
    
    var model: CommentModel? {
        didSet{
            self.contentLabel.attributedText = UILabel.setAttrubutedText(model?.comment_content, lineSpacing: 5.0)
            self.nameLabel.text = model?.comment_author
            self.praiseNumLabel.text = model?.comment_rating_up
            self.trampleNumLabel.text = model?.comment_rating_down
            
            if let dateStr = model?.comment_date{
                self.timeLabel.text = (model?.from_app_name)! + Date.getCommonExpresionOfDate(dateStr)
            }
            
            if let url = model?.avatar {
                self.avatarImageView.extSetImage(URL(string: url))
            }
            self.setUpLyout((model?.isBig)!)
        }
    }
    
    //设置布局
    internal func setUpLyout(_ isBig: Bool) {
        if isBig {
            self.avatarImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(15)
                make.left.equalTo(self.contentView).offset(20)
                make.width.height.equalTo(40)
            }
        } else {
            self.avatarImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(15)
                make.left.equalTo(self.contentView).offset(45)
                make.width.height.equalTo(40)
            }
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView.snp.centerY).offset(-1)
            make.left.equalTo(self.avatarImageView.snp.right).offset(10)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.centerY).offset(1)
            make.left.equalTo(self.avatarImageView.snp.right).offset(10)
        }
        self.trampleNumLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView)
            make.centerY.equalTo(self.avatarImageView)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        self.trampleButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.trampleNumLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.avatarImageView)
            make.width.height.equalTo(8)
        }
        self.praiseNumLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.trampleButton).offset(-15)
            make.centerY.equalTo(self.avatarImageView)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        self.pariseButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.praiseNumLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.avatarImageView)
            make.width.height.equalTo(8)
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(20)
            make.left.equalTo(self.avatarImageView)
            make.right.equalTo(self.contentView).offset(-15)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.praiseNumLabel)
        self.contentView.addSubview(self.pariseButton)
        self.contentView.addSubview(self.trampleNumLabel)
        self.contentView.addSubview(self.trampleButton)
        self.contentView.addSubview(self.contentLabel)
        self.backgroundColor = UIColor(red: 250/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var avatarImageView :UIImageView = {
        let imgView: UIImageView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 20
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel: UILabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    
    lazy var praiseNumLabel: UILabel = {
        let praiseNumLabel = UILabel()
        praiseNumLabel.font = UIFont.systemFont(ofSize: 12)
        return praiseNumLabel
    }()
    
    lazy var pariseButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named:"comment_rating_up_grey"), for: UIControlState())
        button.setImage(UIImage(named:"comment_rating_up_red"), for: .selected)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    internal lazy var trampleNumLabel: UILabel = {
        let trampleNumLabel  = UILabel()
        trampleNumLabel.font = UIFont.systemFont(ofSize: 12)
        return trampleNumLabel
    }()
    
    internal lazy var trampleButton: UIButton = {
        let trampleButton = UIButton()
        trampleButton.setImage(UIImage(named:"comment_rating_down_grey"), for: UIControlState())
        trampleButton.setImage(UIImage(named:"comment_rating_down_black"), for: .selected)
        trampleButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return trampleButton
    }()
    
    internal lazy var contentLabel: UILabel = {
        let contentLabel  = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 13)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        return contentLabel
    }()

    
    func buttonAction(_ sender: AnyObject){
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
    }
    
    class func cellWithTableView(_ tableView: UITableView) -> CommentTableViewCell{
        
        var cell: CommentTableViewCell? = tableView.dequeReuseableCell() as CommentTableViewCell?
        if  cell == nil {
            cell = CommentTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    class func estimateCellHeigth(_ content: String,font: UIFont,size: CGSize) -> CGFloat{
        
        let paragraphStye = NSMutableParagraphStyle()
        paragraphStye.lineSpacing = 5.0
        paragraphStye.firstLineHeadIndent = 0.0
        paragraphStye.hyphenationFactor = 0.0
        paragraphStye.paragraphSpacingBefore = 0.0
        let attributes  = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName:paragraphStye,
            NSKernAttributeName: 1.0
        ] as [String : Any]
        let labelRect: CGRect = NSString(string: content).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes as [String : AnyObject]?, context: nil)
        return labelRect.height + 80
    }
}
