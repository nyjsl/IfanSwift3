//
//  ControllerReusable.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/26.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

enum ScrollviewDirection{
    case none
    case down
    case up
}

//协议中的class关键字用来限制该协议只能应用在类上
protocol ControllerReusable :class {
    
}

/*
 下拉与刷新回调
*/
protocol ScrollViewControllerReusableDataSource: ControllerReusable {
    
    func titleHead() -> MainHeaderView
    
    func readLine() -> UIView
    
    func  menuBtn() -> UIButton
    
    func classifyBtn() -> UIButton
    
    
}

protocol ScrollViewControllerReusableDelegate: ControllerReusable {
    func scrollViewControllerDirectionDidChange(_ direction: ScrollviewDirection)
}

protocol ScrollViewControllerReusable: ControllerReusable,PullToRefreshDataSource {
   
    var tableView: UITableView! {get set}
    
    var scrollViewReusableDatSource: ScrollViewControllerReusableDataSource!{get set}
    
    var scrollViewControllerReusableDelegate: ScrollViewControllerReusableDelegate!{get set}
    
    var pullToRefreshView: PullToRefreshView!{get set}
}



extension ScrollViewControllerReusable where Self: UIViewController{
    
    func titleHead() -> MainHeaderView {
        return self.scrollViewReusableDatSource.titleHead()
    }
    
    func readLine() -> UIView{
        return self.scrollViewReusableDatSource.readLine()
    }
    
    func menuButton() -> UIButton{
        return self.scrollViewReusableDatSource.menuBtn()
    }
    
    func clasifyButton() -> UIButton{
        return self.scrollViewReusableDatSource.classifyBtn()
    }
    
    func scrollView() -> UIScrollView {
        return self.tableView
    }
    
}

extension ScrollViewControllerReusable where Self: UIViewController{
    
    func setUpTableView(){
        if tableView == nil{
            tableView = UITableView()
            tableView.backgroundColor = UIColor.white
            tableView.origin = CGPoint.zero
            tableView.size = CGSize(width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20)
            tableView.separatorStyle = .none
            tableView.sectionFooterHeight = 50
            tableView.tableFooterView = pullToRefreshFootView()
            self.view.addSubview(tableView)
        }
    }
    
    func setUpPullToRefreshView(){
        if pullToRefreshView == nil{
            pullToRefreshView = PullToRefreshView(frame: CGRect(x: CGFloat(0), y: -scenceHeight, width: self.view.width, height: scenceHeight))
            pullToRefreshView.dataSource = self
            self.tableView.insertSubview(pullToRefreshView, at: 0)
            
        }
    }
    
    fileprivate func pullToRefreshFootView() -> UIView{
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
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






