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
    }
    
    
    
    fileprivate lazy var tableHeaderView: UIView! = {
        let tableHeaderView: TableHeaderView = TableHeaderView(model: TableHeaderModelArray.first!)
        return tableHeaderView
    }()
    
    fileprivate var newsFlashModelArray =  Array<CommonModel>()
    
    func getData(_ page: Int = 1){
        
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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

