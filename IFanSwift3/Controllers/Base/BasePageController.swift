//
//  BasePageController.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

import UIKit

class BasePageController: UIViewController,ScrollViewControllerReusable{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setUpTableView()
        setUpPullToRefreshView()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    var tableView: UITableView!
    
    var scrollViewReusableDatSource: ScrollViewControllerReusableDataSource!
    
    var scrollViewControllerReusableDelegate: ScrollViewControllerReusableDelegate!
    
    var pullToRefreshView: PullToRefreshView!
    
    /// 是否正在刷新
    var isRefreshing = false
    var page = 1
        
    var differY:CGFloat = 0
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    
    var lastConentOffSet: CGFloat = 0
    var direction: ScrollviewDirection = .none
}

extension BasePageController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let conentSizeY = scrollView.contentSize.height
        let contentOffSetY = scrollView.contentOffset.y
        
        differY = conentSizeY - contentOffSetY
        
        if contentOffSetY > 0{
            changeScrollVieDirection(contentOffSetY)
        }
    }
    
    func changeScrollVieDirection(_ conentOffSetY: CGFloat){
        if conentOffSetY > lastConentOffSet{
            lastConentOffSet = conentOffSetY
            guard direction != .down else {
                return
            }
            scrollViewControllerReusableDelegate.scrollViewControllerDirectionDidChange(.down)
            direction = .down
        }else if lastConentOffSet > conentOffSetY{
            lastConentOffSet = conentOffSetY
            guard direction != .up else {
                return
            }
            scrollViewControllerReusableDelegate.scrollViewControllerDirectionDidChange(.up)
            direction = .up
        }
    }
}

