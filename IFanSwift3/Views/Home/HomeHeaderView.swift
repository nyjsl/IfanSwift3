//
//  HomeHeaderView.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/22.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

class HomeHeaderView: UIView{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.conentScrollView.addSubview(currentItem)
        self.conentScrollView.addSubview(lastItem)
        self.conentScrollView.addSubview(nextItem)
        
        addSubview(conentScrollView)
        addSubview(pageController)
        addSubview(tagImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeHeaderView.currentItemTapAction))
        currentItem.addGestureRecognizer(tap)
    }
    
    convenience init(frame: CGRect,modelArray: [CommonModel]){
        self.init(frame:frame)
        self.modelArray = modelArray
        pageController.numberOfPage = self.modelArray.count
        self.indexOfCurrentImageItem = 0
        self.setScrollViewOfImage()
        conentScrollView.setContentOffset(CGPoint(x:self.width,y:0), animated: false)
        
        
        
    }
    
    fileprivate func setScrollViewOfImage(){
        
        let currentModel = self.modelArray[self.indexOfCurrentImageItem]
        self.currentItem.imageUrl = currentModel.image!
        self.currentItem.title = currentModel.title!
        self.currentItem.date = "\(currentModel.category!) | \(Date.getCommonExpresionOfDate(currentModel.pubDate!))"
        // 获取下一张图片的模型
        let nextImageModel = self.modelArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImageItem)]
        self.nextItem.imageUrl = nextImageModel.image!
        self.nextItem.title = nextImageModel.title!
        self.nextItem.date = "\(nextImageModel.category!) | \(Date.getCommonExpresionOfDate(nextImageModel.pubDate!))"
        // 获取上衣张图片的模型
        let lastImageModel = self.modelArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImageItem)]
        self.lastItem.imageUrl = lastImageModel.image!
        self.lastItem.title = lastImageModel.title!
        self.lastItem.date = "\(lastImageModel.category!) | \(Date.getCommonExpresionOfDate(lastImageModel.pubDate!)))"

    }
    
    typealias CurrentItemTapCallback = (_ index: Int) -> Void
    
    fileprivate var callback: CurrentItemTapCallback?
    
    func registerCallBack(callback: CurrentItemTapCallback?){
        self .callback = callback
    }
    
    @objc func currentItemTapAction(){
        if let cl = callback{
            cl(indexOfCurrentImageItem)
        }
    }
    
    fileprivate var timer: Timer?
    
    fileprivate func addTimer(){
        if self.timer == nil{
            self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(HomeHeaderView.timerAction), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer!, forMode: .commonModes)
            
        }
    }
    
    fileprivate func removeTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func timerAction(){
        conentScrollView.setContentOffset(CGPoint(x: self.width*2, y: 0), animated: true)
    }
    
    var indexOfCurrentImageItem: Int! = 0{
        didSet{
            self.pageController.currentPage = indexOfCurrentImageItem
        }
    }
    
    var modelArray: [CommonModel]!{
//        willSet{
//            self.modelArray = newValue
//        }
        
        didSet{
            guard self.modelArray.count>0 else {
                return
            }
            conentScrollView.isUserInteractionEnabled = true
            conentScrollView.isScrollEnabled = !(self.modelArray.count == 1)
            pageController.numberOfPage = self.modelArray.count
            setScrollViewOfImage()
            conentScrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
            tagImageView.isHidden = false
            self.addTimer()
        }
    }
    
    private lazy var conentScrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height-45))
        scrollView.isUserInteractionEnabled = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.width*3, height: 0)
        scrollView.delegate = self
        return scrollView
    }()
    
    
    fileprivate lazy var currentItem: HomeHeaderItemView = {
        let item = HomeHeaderItemView(frame: CGRect(x: self.width, y: 0, width: self.width, height: self.conentScrollView.height))
        return item
    }()
    
    fileprivate lazy var lastItem: HomeHeaderItemView = {
        let item = HomeHeaderItemView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.conentScrollView.height))
        return item
    }()
    
    fileprivate lazy var nextItem: HomeHeaderItemView = {
        var nextItem: HomeHeaderItemView = HomeHeaderItemView()
        nextItem.frame = CGRect(x: self.width * 2, y: 0, width: self.width, height: self.conentScrollView.height)
        return nextItem
    }()
    
    fileprivate lazy var pageController: HomePageController = {
        var pageController : HomePageController = HomePageController()
        pageController.frame = CGRect(x: UIConstant.UI_MARGIN_10, y: self.conentScrollView.height-35, width: self.width, height: 20)
        return pageController
    }()
    
    fileprivate lazy var tagImageView: UIImageView = {
        var tagImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 25))
        tagImageView.isHidden = true
        tagImageView.center = CGPoint(x: self.center.x, y: self.height-13)
        tagImageView.image = UIImage(imageLiteralResourceName: "tag_latest_press")
        tagImageView.contentMode = UIViewContentMode.scaleAspectFit
        return tagImageView
    }()
    
    
    fileprivate func getLastImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index - 1
        if tempIndex == -1 {
            return self.modelArray.count - 1
        } else {
            return tempIndex
        }
    }
    
    /**
     得到下一张图片的下标
     
     - parameter index: 当前图片下标位置
     
     - returns: 下一个图片下标位置
     */
    fileprivate func getNextImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index + 1
        return tempIndex < self.modelArray.count ? tempIndex : 0
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderView: UIScrollViewDelegate{
    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeTimer()
    }
    
    //停止拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            self.scrollViewDidEndDecelerating(scrollView)
        }
        self.addTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrentImageItem = self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImageItem)
        } else if offset == self.frame.size.width * 2 {
            self.indexOfCurrentImageItem = self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImageItem)
        }
        // 重新布局图片
        self.setScrollViewOfImage()
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
}
