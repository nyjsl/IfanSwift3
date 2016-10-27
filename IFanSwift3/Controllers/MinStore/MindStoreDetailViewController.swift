//
//  MindStoreDetailViewController.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/27.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
class MindStoreDetailViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        self.view.addSubview(headerBack)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        headerBack.snp.makeConstraints { (make) in
            make.right.left.top.equalTo(self.view)
            make.height.equalTo(50)
            
        }
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    convenience init(headerModel: MindStoreModel){
        self.init()
        self.headerModel = headerModel
    }
    
    fileprivate var headerModel: MindStoreModel!
    
    fileprivate var voteModelArray = [MindStoreVoteModel]()
    fileprivate var commentModelArray = [MindStoreVoteModel]()
    
    fileprivate var offset = 1
    fileprivate var isRefreshing: Bool = true
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    var differY: CGFloat = 0
    
    fileprivate lazy var headerBack: HeaderBackView = {
        let view: HeaderBackView = HeaderBackView(title: "MindStore")
        view.delegate = self
        return view
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 50
        tableView.tableFooterView = self.pullToRefreshFootView()
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
}

extension MindStoreDetailViewController {
    fileprivate func pullToRefreshFootView() -> UIView {
        
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25) )
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.center = CGPoint(x: self.view.center.x, y: 25)
        activityView.startAnimation()
        let footView = UIView()
        footView.origin = CGPoint.zero
        footView.size = CGSize(width: 50, height: 50)
        footView.addSubview(activityView)
        return footView
    }
}

extension MindStoreDetailViewController: HeaderViewDelegate{
    func backButtonDidClick() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension MindStoreDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MindStoreTableViewCell.cellWithTableView(tableView)
        cell.model = headerModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MindStoreTableViewCell.estimateCellHeight(headerModel.title!, tagline: headerModel.tagline!)
    }
}
