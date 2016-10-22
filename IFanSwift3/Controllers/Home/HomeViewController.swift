//
//  HomeViewController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class HomeViewController: BasePageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pullToRefreshView.delegate = self
        tableView.sectionHeaderHeight = tableHeaderView.height
        tableView.tableHeaderView = tableHeaderView
        tableHeaderView.registerCallBack { [unowned self] in
            let ifDetailsController = DetailController(model: self.headerModelArray![$0], navTitle: "首页")
            self.navigationController?.pushViewController(ifDetailsController, animated: true)
        }
        getNormalData()
    }
    // 列表数据
    fileprivate var latestCellLayout = Array<HomePopbarLayout>()
    fileprivate var headerModelArray: [CommonModel]?
    
    fileprivate var hotDataError: Swift.Error?
    fileprivate var latestDataError: Swift.Error?
    
    fileprivate lazy var tableHeaderView: HomeHeaderView = {
        return HomeHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.width*0.625+45))
    }()
    
    fileprivate func getNormalData(){
        
        isRefreshing = true
        
        let group = DispatchGroup()
        group.enter()
        
        let type: CommonModel? = CommonModel(dict: [:])
        IFanService.shareInstance.getData(APIConstant.newsFlash_latest(page), t: type, keys: ["data"], successHandle: { (modelArray) in
            
            self.headerModelArray = modelArray
            group.leave()
            
            }) { (error) in
                print(error)
                self.pullToRefreshView.endRefresh()
                self.hotDataError = error
        }
        
        page = 1
        group.enter()
        
        IFanService.shareInstance.getLatestLayout(APIConstant.home_latest(page), successHandle: { [unowned self](layoutArray) in
            self.latestCellLayout.removeAll()
            layoutArray.forEach {
                self.latestCellLayout.append($0)
            }
            group.leave()
            }, errorHandle: { (error) in
                print(error)
                self.pullToRefreshView.endRefresh()
                self.latestDataError = error
        })
        
        group.notify(queue: DispatchQueue.main) {
            if self.hotDataError == nil && self.latestDataError == nil {
                self.tableHeaderView.modelArray = self.headerModelArray
                self.tableView.reloadData()
                // 请求成功让page+1
                self.page+=1
            } else {
                // 这里处理网络出现问题
                self.pullToRefreshView.endRefresh()
            }
            
            self.isRefreshing = false
            self.pullToRefreshView.endRefresh()
        }
        

        

        
    }

}

extension HomeViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if differY < happenY{
            if !isRefreshing{
                // 这里处理上拉加载更多
                IFanService.shareInstance.getLatestLayout(APIConstant.home_latest(page), successHandle: { (layoutArray) in
                    layoutArray.forEach{
                        self.latestCellLayout.append($0)
                    }
                    self.isRefreshing = false
                    self.tableView.reloadData()
                    }, errorHandle: { (error) in
                        print(error)
                })
                
                isRefreshing = true
                
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestCellLayout.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellModel = latestCellLayout[(indexPath as NSIndexPath).row].model
        if cellModel?.post_type == PostType.dasheng {
            let cell = cell as! HomeLatestTextCell
            cell.homePopbarLayout = latestCellLayout[(indexPath as NSIndexPath).row]
        } else if cellModel?.post_type == PostType.data {
            let cell = cell as! HomeLatestDateCell
            cell.popularLayout = latestCellLayout[(indexPath as NSIndexPath).row]
        } else {
            let cell = cell as! HomeLatestImageCell
            cell.popularLayout = latestCellLayout[(indexPath as NSIndexPath).row]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = latestCellLayout[(indexPath as NSIndexPath).row].model
        var cell : UITableViewCell!
        if cellModel?.post_type == PostType.dasheng {
            cell = HomeLatestTextCell.cellWithTableView(tableView)
        } else if cellModel?.post_type == PostType.data {
            cell = HomeLatestDateCell.cellWithTableView(tableView)
        } else {
            cell = HomeLatestImageCell.cellWithTableView(tableView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return latestCellLayout[(indexPath as NSIndexPath).row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model: CommonModel = latestCellLayout[(indexPath as NSIndexPath).row].model {
            let ifDetailsController = DetailController(model: model, navTitle: "首页")
            self.navigationController?.pushViewController(ifDetailsController, animated: true)
        }
    }

}

extension HomeViewController: PullToRefreshDelegate{
    
    func pullToRefreshViewDidRefresh(_ pullToRefreshView: PullToRefreshView) {
        getNormalData()
    }
}
