//
//  NewsFlashController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class NewsFlashViewController: BasePageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefreshView.delegate = self
        
        tableView.sectionHeaderHeight = tableHeaderView.height
        tableView.tableHeaderView = tableHeaderView
        
        getData()

    }
    
    
    
    fileprivate lazy var tableHeaderView: UIView! = {
        let tableHeaderView: TableHeaderView = TableHeaderView(model: TableHeaderModelArray.first!)
        return tableHeaderView
    }()
    
    fileprivate var newsFlashModelArray =  Array<CommonModel>()
    
    func getData(_ page: Int = 1){
        isRefreshing = true
        let type: CommonModel? = CommonModel(dict: [:])
        IFanService.shareInstance.getData(APIConstant.newsFlash_latest(page), t: type, keys: ["data"], successHandle: { (modelaArray) in
            if page == 1{
                self.page = 1
                self.newsFlashModelArray.removeAll()
            }
            self.newsFlashModelArray.forEach({ (model) in
                self.newsFlashModelArray.append(model)
            })
            
            self.page += 1
            self.isRefreshing = false
            self.tableView.reloadData()
            self.pullToRefreshView.endRefresh()
            }) { (error) in
                print(error)
                self.pullToRefreshView.endRefresh()
        }
    }

}

extension NewsFlashViewController{
    
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

extension NewsFlashViewController: PullToRefreshDelegate{
    func pullToRefreshViewDidRefresh(_ pullToRefreshView: PullToRefreshView) {
        getData()
    }
}

extension NewsFlashViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFlashModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsFlashTableViewCell.cellWithTableView(tableView)
        cell.model = newsFlashModelArray[indexPath.row]
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewsFlashTableViewCell.estimateCellHeight(self.newsFlashModelArray[indexPath.row].title!) + 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.newsFlashModelArray[indexPath.row]
        let safariVC = SafariController(model: model)
        self.present(safariVC, animated: true, completion: nil)
    }
}

