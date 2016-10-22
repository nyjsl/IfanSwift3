//
//  MenuController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImg)
        self.view.addSubview(mainTableView)
    }
    
    private lazy var backgroundImg: UIImageView = {
        var bgImg:UIImageView = UIImageView(frame: self.view.bounds)
        bgImg.contentMode = .scaleAspectFit
        bgImg.image = UIImage(imageLiteralResourceName: "profile_background")
        return bgImg
    }()
    
    private lazy var mainTableView: UITableView = {
        var tableView: UITableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.clear
        let headerView = MenuHeaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 100))
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 100
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension MenuViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuTableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuTableViewCell.cellWithTableView(tableView: tableView)
        cell.model = MenuTableItems[indexPath.row]
        return cell
    }
    
    
}

extension MenuViewController: MenuHeaderViewDelegate{
    
    func settingBtnDidClkci(_ headerView: MenuHeaderView, settingBtn: UIButton) {
        let _ = self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    func searchBtnDidClick(_ headerView: MenuHeaderView, searchBtn: UIButton) {
        //TODO
    }
}
