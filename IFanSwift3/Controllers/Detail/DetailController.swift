//
//  DetailController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class DetailController: UIViewController {
   
    var shareView: ShareView? //confirm to protocol
    var shadowView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(wkWebView)
        self.view.addSubview(toolBar)
        self.view.addSubview(headerBack)
        self.setupLayout()

        self.toolBar.commentButton.showICon(model?.comments ?? nil)
        self.toolBar.praizeButton.setTitle(String(format: "(点赞(%d))",(model?.like!)!), for: UIControlState())
        self.wkWebView.load(URLRequest(url: URL(string: (self.model?.link)!)!))
    }
    
    fileprivate func setupLayout(){
        self.wkWebView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        self.toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        self.headerBack.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            self.headerTopConstranit = make.top.equalTo(self.view).constraint
            make.height.equalTo(50)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    convenience init(model: CommonModel,navTitle: String){
        self.init()
        self.model = model
        self.navTitle = navTitle
        headerBack.title = navTitle
    }
    
    fileprivate lazy var wkWebView: WKWebView = {
       let webView = WKWebView()
        return webView
    }()
    
    fileprivate var model: CommonModel?
    fileprivate var navTitle: String!
    
    //底部工具栏
    fileprivate lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    //顶部返回栏
    
    fileprivate lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "")
        headerBack.delegate = self
        return headerBack
        
    }()
    
    
    fileprivate var lastPosition: CGFloat = 0
    
    fileprivate var headerTopConstranit: Constraint? = nil

}

extension DetailController: ShareViewDelegate,ShareReusable{
    

    
    func wxShareBtnDidClick() {
        shareToFriend((self.model?.excerpt)!, shareImageUrl: (model?.image)!, shareUrl: (model?.link)!, shareTitle: (model?.title)!)
    }
    
    func wxCircleShareBtnDidClick() {
        shareToFriendsCircle((model?.excerpt)!, shareTitle: (model?.title)!, shareUrl: (model?.link)!, shareImageUrl: (model?.image)!)
    }
    
    func shareMoreBtnDidClick() {
        hideShareView()
    }
    
    
}

extension DetailController: HeaderViewDelegate{
    func backButtonDidClick() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}


extension DetailController: ToolBarDelegate{
    
    func commentButtonDidClick() {
        let detaiCommentVc = DetailCommentController(id: model!.ID)
        self.navigationController?.pushViewController(detaiCommentVc, animated: true)
    }
    
    func praiseButtonDidClick() {
        self.toolBar.praizeButton.isSelected = !self.toolBar.praizeButton.isSelected
    }
    
    func shareButtonDidClick() {
        self.showShareView()
    }
    
    func editCommentDidClick() {
        debugPrint("eidtCommon")
    }
    
    
}


extension DetailController: WKNavigationDelegate,UIScrollViewDelegate{
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideProgress()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPositon = scrollView.contentOffset.y
        if currentPositon - self.lastPosition > 30  && currentPositon>0{
            self.headerTopConstranit?.update(offset: 50)
            UIView.animate(withDuration: 0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            self.lastPosition = currentPositon
        }else if self.lastPosition - currentPositon > 10{
           self.headerTopConstranit?.update(offset: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            self.lastPosition = currentPositon
        }
        
    }
}
