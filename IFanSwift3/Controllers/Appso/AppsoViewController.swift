//
//  AppsoViewController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class AppsoViewController: BasePageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefreshView.delegate = self
        
        tableView.sectionHeaderHeight = tableHeaderView.height
        tableView.tableHeaderView = tableHeaderView
        
        getData()
    }
    
    func getData(_ page: Int = 1) {
        isRefreshing = true
        
        let type: CommonModel? = CommonModel(dict: [:])
        IFanService.shareInstance.getData(APIConstant.appSo_latest(page), t: type, keys: ["data"], successHandle: { (modelArray) in
            
            if page == 1 {
                self.page = 1
                self.appSoModelArray.removeAll()
            }
            // 添加数据
            modelArray.forEach {
                self.appSoModelArray.append($0)
            }
            self.page += 1
            self.isRefreshing = false
            self.tableView.reloadData()
            self.pullToRefreshView.endRefresh()
            
        }) { (error) in
        }
        
    }
    var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray[2])
    }()
    
    var appSoModelArray = Array<CommonModel>()

}

// MARK: - 下拉刷新回调
// MARK: - 下拉刷新回调
extension AppsoViewController: PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension AppsoViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                getData(page)
            }
        }
    }
}



// MARK: - tableView代理和数据源
extension AppsoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        let curModel = self.appSoModelArray[(indexPath as NSIndexPath).row];
        
        
        if curModel.app_icon_url != "" {
            cell    = AppSoTableViewCell.cellWithTableView(tableView)
            (cell as! AppSoTableViewCell).model = curModel
        } else {
            cell    = PlayingZhiTableViewCell.cellViewTableView(tableView: tableView)
            (cell as! PlayingZhiTableViewCell).model = curModel
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appSoModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppSoTableViewCell.estimateCellHeight(self.appSoModelArray[(indexPath as NSIndexPath).row].title!) + 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let appSoModel: CommonModel = self.appSoModelArray[indexPath.row]
         let detailVc = DetailController(model: appSoModel, navTitle: "AppSo")
         self.navigationController?.pushViewController(detailVc, animated: true)
        
    }
}



