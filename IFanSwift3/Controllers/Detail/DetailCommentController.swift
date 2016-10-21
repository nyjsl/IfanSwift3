//
//  DetailCommentController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class DetailCommentController: UIViewController{
    
    var id: String!
    
    fileprivate var detailsCommentModelArray: Array<CommentModel> = Array()
    
    convenience init(id: String!){
        self.init()
        self.id = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.setupLayout()
        getData()
    }
    
    fileprivate func getData(){
        
        let type: CommentModel? = CommentModel(dict: [:])
        IFanService.shareInstance.getData(APIConstant.Comments_latest(self.id), t: type, keys: ["data", "all"], successHandle: { (modelArray) in
            modelArray.forEach({ (model) in
                self.detailsCommentModelArray.append(model)
            })
            self.tableView.reloadData()
            }) { (error) in
                print(error)
        }
    }
    
    fileprivate func setupLayout(){
        self.headerView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(84)
        }
        self.tableView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.headerView.snp_bottom)
        }
    }
    
    fileprivate lazy var headerView: CommentHeaderView = {
        
        let headerView = CommentHeaderView(model: nil)
        headerView.delegate = self
        return headerView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame:self.view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
        return tableView
    }()
}

extension DetailCommentController:CommentHeaderDelegate{
    
    func resetBtnSelectState(){
        for item: AnyObject in self.headerView.bottomView.subviews{
            if item is UIButton{
                let itemBtn: UIButton = item as! UIButton
                itemBtn.isSelected = false
            }
        }
    }
    
    func gobackBtnDidClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func timeSortedBtnDidClick(_ sender: UIButton) {
        if !sender.isSelected{
            resetBtnSelectState()
            self.detailsCommentModelArray.sort(by: { (first, second) -> Bool in
                return Date.isEarlier(first.comment_date, dateSecond: second.comment_date)
            })
            self.tableView.reloadData()
            sender.isSelected = true
        }
    }
    
    func heatSortedBtnDidClick(_ sender: UIButton) {
        if !sender.isSelected {
            resetBtnSelectState()
            
            self.detailsCommentModelArray.sort(by: { (model1, model2) -> Bool in
                Int(model1.comment_rating_up) > Int(model2.comment_rating_up)
            })
            self.tableView.reloadData()
            
            sender.isSelected = true
        }

    }
}

extension DetailCommentController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailsCommentModelArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model = self.detailsCommentModelArray[(indexPath as NSIndexPath).row]
        let cell = CommentTableViewCell.cellWithTableView(tableView)
        if model.comment_parent == "0"{//不是子评论
            cell.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 0)
            model.isBig = true
        }else{//子评论
            cell.layoutMargins =  UIEdgeInsetsMake(0, 45, 0, 0)
            model.isBig = false
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model: CommentModel = self.detailsCommentModelArray[(indexPath as NSIndexPath).row]
        
        if model.comment_parent == "0" {
            return CommentTableViewCell.estimateCellHeigth(model.comment_content,
                                                           font: UIFont.systemFont(ofSize: 13),
                                                           size: CGSize(width: UIConstant.SCREEN_WIDTH-30, height: 2000))
        } else {
            return CommentTableViewCell.estimateCellHeigth(model.comment_content,
                                                                font: UIFont.systemFont(ofSize: 13),
                                                                size: CGSize(width: UIConstant.SCREEN_WIDTH-60, height: 2000))
        }

    }
    
}
