//
//  PlayingzhiViewController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class PlayingzhiViewController: BasePageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = tableHeaderView
        tableView.sectionHeaderHeight = tableHeaderView.height
        pullToRefreshView.delegate = self
        
        getData()
    }
    
    fileprivate var playzhiModelArray: Array<CommonModel> = Array<CommonModel>()
    
    fileprivate lazy var tableHeaderView: UIView = {
        return TableHeaderView(model:TableHeaderModelArray[1])
    }()
    
    
    fileprivate func getData(page: Int = 1){
        
        isRefreshing = true
        
        let type: CommonModel? = CommonModel(dict: [:])
        IFanService.shareInstance.getData(APIConstant.newsFlash_latest(page), t: type, keys: ["data"], successHandle: { (modelArray) in
            if page == 1{
                self.page = 1
                self.playzhiModelArray.removeAll()
            }
            modelArray.forEach{
                self.playzhiModelArray.append($0)
            }
            self.page += 1
            self.isRefreshing = false
            self.tableView.reloadData()
            self.pullToRefreshView.endRefresh()
            }) { (error) in
                print(error)
        }
        
    }
}

extension PlayingzhiViewController{
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                getData(page: page)
            }
        }
    }
}

extension PlayingzhiViewController: PullToRefreshDelegate{
    func pullToRefreshViewDidRefresh(_ pullToRefreshView: PullToRefreshView) {
        getData()
    }
}

extension PlayingzhiViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playzhiModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlayingZhiTableViewCell.cellViewTableView(tableView: tableView)
        cell.model = playzhiModelArray[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsMake(0, 32, 0, 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.playzhiModelArray[indexPath.row]
        let detailController = DetailController(model: model, navTitle: "玩物志")
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlayingZhiTableViewCell.estimateCellHeight(self.playzhiModelArray[indexPath.row].title!) + 20
    }
}
