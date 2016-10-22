//
//  MenuTableModel.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
struct MenuTableModel {
    let image: UIImage
    let title: String
}

let MenuTableItems = [
    MenuTableModel(image: UIImage(named:"ic_login")!, title: "马上登录"),
    MenuTableModel(image: UIImage(named:"ic_report")!, title: "寻求报道"),
    MenuTableModel(image: UIImage(named:"ic_about")!, title: "关于爱范儿")
]
