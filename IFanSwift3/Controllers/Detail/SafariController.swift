//
//  SafariController.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/25.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class SafariController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(wkWevView)
        self.view.addSubview(bottomBar)
        self.loadData()
    }
    
    func setupLatyou(){
        self.bottomBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(45)
        }
    }
    
    func loadData(){
        var links: [String] = (model!.content.getSutiableString("http(.*?)html"))
        if links.count == 0 {
            links = (model!.content.getSutiableString("http(.*?)htm"))
        }
        if links.count != 0 {
            urlStr = links[0]
            self.wkWevView.load(URLRequest(url: URL(string: urlStr!)!))
        }
    }
    
    func bottomBarSetupLayout(){
        self.backButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.bottomBar).offset(30)
            make.top.equalTo(self.bottomBar).offset(20)
            make.width.height.equalTo(15)
        }
        
        self.shareButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-30)
            make.top.equalTo(self.bottomBar).offset(15)
            make.width.height.equalTo(20)
        }
        
        self.safariButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.shareButton.snp.left).offset(-35)
            make.top.equalTo(self.bottomBar).offset(15)
            make.width.height.equalTo(20)
        }
        
        self.reloadButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.safariButton.snp.left).offset(-35)
            make.top.equalTo(self.bottomBar).offset(15)
            make.width.height.equalTo(18)
        }

    }
    
    fileprivate var model: CommonModel?
    
    var shadowView: UIView?
    
    var shareView: ShareView?
    
    var urlStr: String?
    
    convenience init(model: CommonModel?){
        self.init()
        self.model = model
    }
    
    fileprivate lazy var wkWevView: WKWebView = {
        let webView: WKWebView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        return webView
    }()
    
    fileprivate lazy var bottomBar: UIView = {
        let bottmBar: UIView = UIView()
        bottmBar.backgroundColor = UIColor.black
        bottmBar.addSubview(self.backButton)
        bottmBar.addSubview(self.reloadButton)
        bottmBar.addSubview(self.shareButton)
        bottmBar.addSubview(self.safariButton)
        return bottmBar
    }()
    
    func backButtonDidClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadBtnDidClick(){
        self.wkWevView.loadHTMLString("", baseURL: nil)
        self.wkWevView.load(URLRequest(url: URL(string: self.urlStr!)!))
    }
    
    func shareBtnDidClick(){
        showShareView()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func safariBtnDidClick(){
        
        if #available(iOS 10, *){
            UIApplication.shared.open(URL(string: self.urlStr!)!, options: [:], completionHandler: nil)
        }else{
           
            UIApplication.shared.openURL(URL(string: self.urlStr!)!)
        }
        
        
    }
    
    fileprivate lazy var backButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "ic_close"), for: UIControlState())
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonDidClick), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var shareButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "ic_comment_bar_share"), for: UIControlState())
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(shareBtnDidClick), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var reloadButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "ic_refresh"), for: UIControlState())
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(reloadBtnDidClick), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var safariButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(#imageLiteral(resourceName: "ic_system_browser"), for: UIControlState())
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(safariBtnDidClick), for: .touchUpInside)
        return button
    }()
    
}


extension SafariController: ShareViewDelegate,ShareReusable{
    func wxShareBtnDidClick() {
        //TODO
    }
    
    func wxCircleShareBtnDidClick() {
        //TODO
    }
    
    func shareMoreBtnDidClick() {
        hideShareView()
    }
}

extension SafariController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideProgress()
    }
}
