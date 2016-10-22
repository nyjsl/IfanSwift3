//
//  SettingViewController.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        let headerView = SettingHeadView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: 44))
        headerView.registerCallBack { 
            [unowned self] in
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(headerView)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(self.view.height-UIConstant.UI_NAV_HEIGHT)
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = UIConstant.UI_NAV_HEIGHT
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = SettingModelArray[indexPath.row]
        let cell = SettingViewCell(type: model.type)
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        return 70
    }
}
