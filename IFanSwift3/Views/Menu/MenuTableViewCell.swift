//
//  MenuTableViewCell.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewCell: UITableViewCell,Reuseable{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(titleLabel)
        
        iconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.left.equalTo(self.contentView).offset(UIConstant.UI_MARGIN_20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconView.snp.right).offset(30)
            make.top.bottom.right.equalTo(self.contentView)
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: MenuTableModel!{
        didSet{
            self.iconView.image = model.image
            self.titleLabel.text = model.title
        }
    }
    
    private lazy var iconView: UIImageView = {
        var img: UIImageView = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIConstant.UI_FONT_16
        titleLabel.textColor = UIConstant.UI_COLOR_GrayTheme
        return titleLabel
    }()
    
    class func cellWithTableView(tableView: UITableView) -> MenuTableViewCell{
        var cell = tableView.dequeReuseableCell() as MenuTableViewCell?
        if cell == nil{
            cell = MenuTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
        
    }
}
