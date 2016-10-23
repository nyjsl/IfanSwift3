//
//  PulltoRefreshView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/8.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import SnapKit

public typealias PullToRefreshTask =  ()-> Void

protocol PullToRefreshDataSource: class {
    
    /*
     顶部标题快讯，首页。。。
    */
    func titleHead() -> MainHeaderView
    /*
    顶部红线
    */
    
    func readLine() -> UIView
    /*
     菜单按钮
     */
    func menuButton() -> UIButton
    /*
     分类按钮
     */
    func clasifyButton() -> UIButton
    /*
     tableView
     */
    func scrollView() -> UIScrollView
}

@objc protocol PullToRefreshDelegate: class{
    @objc optional func pullToRefreshViewWillRefresh(_ pullToRefreshView: PullToRefreshView)
    func pullToRefreshViewDidRefresh(_ pullToRefreshView: PullToRefreshView)
}

enum RefreshState{
    case normal //普通状态
    case pulling   //松开就可以刷新的状态
    case refreshing //正在刷新的状态
}

enum RefreshType{
    case none
    case pullToRefresh
    case loadMoe
}

let scenceHeight: CGFloat = 300

let happenOffsetY: CGFloat = 60

class PullToRefreshView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.addSubview(statusLabel)
        self.addSubview(activityView)
    }
    
    override func layoutSubviews() {
        frame = CGRect(x: 0, y: -scenceHeight, width: UIConstant.SCREEN_WIDTH, height: scenceHeight)
        self.statusLabel.frame = CGRect(x: 0, y: frame.height-20, width: UIConstant.SCREEN_WIDTH, height: 15)
        self.activityView.center = CGPoint(x: self.frame.size.width / 2, y: self.statusLabel.y - activityView.height )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var scrollView: UIScrollView!
    fileprivate var headerView: MainHeaderView!
    fileprivate var readLine: UIView!
    fileprivate var menuButton: UIButton!
    fileprivate var classifyButton: UIButton!
    
    fileprivate var progressPercentage:CGFloat = 0
    
    fileprivate var pullToRerefreshTask: PullToRefreshTask?
    
    var dataSource: PullToRefreshDataSource?{
        willSet{
            
            if let value = newValue{
                headerView = value.titleHead()
                readLine = value.readLine()
                menuButton = value.menuButton()
                classifyButton = value.clasifyButton()
                scrollView = value.scrollView()
            }
        }
        
        didSet{
            if let old = oldValue{
                old.scrollView().removeObserver(self, forKeyPath: "contentOffset")
                old.scrollView().removeObserver(self, forKeyPath: "contentSize")

            }
        }
    }
    
    
    
    func endRefresh() {
        self.state = RefreshState.normal
        self.setupNormalDataAnimation()
    }
    
    
//    代理回调
    weak var delegate: PullToRefreshDelegate?
    
    var oldState: RefreshState?
    
    var state: RefreshState = .normal{
        
        willSet{
            oldState = state
        }
        
        didSet{
            switch state {
            case .normal:
                self.statusLabel.text = "下拉即可刷新"
                if oldState == RefreshState.refreshing{
                    self.activityView.isHidden = true
                    self.readLine.isHidden = true
                    
                   
                    UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                        self.scrollView.contentInset = UIEdgeInsets.zero
                        }, completion: { (_) in
                            self.setupNormalDataAnimation()
                    })
                }
                
                
            case .pulling:
                self.statusLabel.text = "释放即可刷新"
            case .refreshing:
                self.readLine.isHidden = true
                self.activityView.isHidden = false
                self.activityView.startAnimation()
                if let delegate = self.delegate{
                    delegate.pullToRefreshViewWillRefresh?(self)
                    UIView.animate(withDuration: 0.2, animations: {
                        
                        let top: CGFloat = happenOffsetY
                        var inset: UIEdgeInsets = self.scrollView.contentInset
                        inset.top = top
                        self.scrollView.contentInset = inset
                        var offset:CGPoint = self.scrollView.contentOffset
                        offset.y = -top
                        self.scrollView.contentOffset = offset
                        }, completion: { (_) in
                            self.readLine.frame = CGRect(x: self.center.x, y: 0, width: 0, height: 1)
                    })
                    
                    //执行block
                    let time = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: time, execute: {
                        delegate.pullToRefreshViewDidRefresh(self)
                    })

                }
            }
        }
    }
    
    //状态标签
    fileprivate lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        label.textColor = UIColor.white
        label.text = "下拉即可刷新"
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    //菊花
    fileprivate lazy var activityView: ActivityIndicatorView = {
        let activityView = ActivityIndicatorView()
        activityView.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        activityView.isHidden = true
        return activityView
    }()
    
}


extension PullToRefreshView {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath , keyPath == "contentOffset" {
            // 如果处于刷新状态，直接退出
            guard state != RefreshState.refreshing else {
                return
            }
            // 拿到当前contentoffset的y值
            let currentOffsetY : CGFloat = scrollView.contentOffset.y
            
            if (currentOffsetY > 0) {
                setupNormalDataAnimation()
                return
            }
            if fabs(currentOffsetY) > 10 {
                setupRedLineAnimation()
            }
            setupHeaderViewAnimation()
            
            if scrollView.isDragging {
                if fabs(currentOffsetY) > happenOffsetY && self.state == RefreshState.normal {
                    state = RefreshState.pulling
                } else if fabs(currentOffsetY) <= happenOffsetY && self.state == RefreshState.pulling {
                    state = RefreshState.normal
                }
            } else if self.state == RefreshState.pulling {
                state = RefreshState.refreshing
            }
        }

    }
    
    
    fileprivate func setupRedLineAnimation() {
        let width = max(1,(1-progressPercentage)*40)
        let height = max(1,fabs(scrollView.contentOffset.y)-10)
        
        UIView.animate(withDuration: 0.01, animations: {
            self.readLine.frame = CGRect(x: self.center.x-width*0.5, y: 0, width: width, height: height)
        })
    }
    
    fileprivate func setupHeaderViewAnimation() {
        let refreshViewVisibleHeight = max(0, -(self.scrollView.contentOffset.y + scrollView.contentInset.top))
        progressPercentage = min(1, refreshViewVisibleHeight / happenOffsetY)
        headerView.alpha = min(1, max(1-progressPercentage/0.2, 0))
        menuButton.alpha = min(1, max(1-progressPercentage/0.2, 0))
        if !classifyButton.isHidden {
            classifyButton.alpha = min(1, max(1-progressPercentage/0.2, 0))
        }
    }
    
    fileprivate func setupNormalDataAnimation() {
        UIView.animate(withDuration: 0.1) {
            self.readLine.frame = CGRect(x: self.center.x-20, y: 0, width: 40, height: 1)
            self.headerView.alpha = 1
            self.menuButton.alpha = 1
        }
    }
}







