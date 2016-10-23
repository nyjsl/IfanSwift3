//
//  TableHeaderModel.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/23.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

struct TableHeaderModel {
    let backImage: UIImage
    let title: String
    let detail: String
    let tagImage: UIImage
}

let TableHeaderModelArray = [
    TableHeaderModel(backImage: #imageLiteral(resourceName: "buzz_header_background"), title: "快讯", detail: "最新的资讯快报", tagImage: #imageLiteral(resourceName: "tag_happeningnow")),
    TableHeaderModel(backImage: #imageLiteral(resourceName: "coolbuy_header_background"), title: "玩物志", detail: "值得买的未来生活", tagImage: #imageLiteral(resourceName: "tag_coolbuy")),
    TableHeaderModel(backImage: #imageLiteral(resourceName: "appso_header_background"), title: "AppSo", detail: "智能手机更好用的秘密", tagImage: #imageLiteral(resourceName: "tag_appsolution")),
    TableHeaderModel(backImage: UIImage(named: "mind_store_header_background")!,title: "MindStore", detail: "在这里发现最好的产品和想法", tagImage: UIImage(named: "tag_latest_press")!),
]

