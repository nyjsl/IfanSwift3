//
//  SettingTableModel.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

let SettingModelArray = [
    SettingTableModel(type: .detailTitle, title: nil, detail: "常用设置", isSwitch: false, isImage: false),
    SettingTableModel(type: .switch, title: "无图环境", detail: "非Wi-Fi环境下不加载图片", isSwitch: true, isImage: false),
    SettingTableModel(type: .default, title: "清除缓存", detail: "已缓存0M", isSwitch: false, isImage: false),
    SettingTableModel(type: .image, title: "给我们好评", detail: nil, isSwitch: false, isImage: true)
]

struct SettingTableModel {
    
    let type: SettingCellType
    let title: String?
    let detail: String?
    let isSwitch: Bool
    let isImage: Bool
}
