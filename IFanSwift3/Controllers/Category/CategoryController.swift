//
//  CategoryController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/10.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import SnapKit
class CategoryController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    convenience init(categoryModel: CategoryModel){
        self.init()
        self.view.addSubview(tableView)
        self.tableView.insertSubview(CategoryHeaderView(frame: CGRect(x: 0, y: -self.cellHeaderViewHeight, width: self.view.width, height: self.cellHeaderViewHeight)), at: 0)
        self.view.addSubview(headerView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(backBtn)
        self.categoryModel = categoryModel
        self.headerView.model = categoryModel
        titleLabel.text = categoryModel.title
        setupLayout()
        headerHappenY = -(headerView.height+cellHeaderViewHeight)
        
        getData()
        
    }
    
    fileprivate func setupLayout(){
        self.backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view).offset(UIConstant.UI_MARGIN_20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.centerY.equalTo(backBtn.snp.centerY)
            make.height.equalTo(20)
        }
    }
    
    fileprivate var headerHappenY:CGFloat = 0
    
    fileprivate var categoryModel: CategoryModel!
    
    fileprivate var isRefreshing: Bool = true
    
    fileprivate var page: Int = 1
    
    fileprivate lazy var headerView: CategoryListHeaderView = {
        let view = CategoryListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 200*UIConstant.SCREEN_WIDTH / UIConstant.IPHONE5_HEIGHT))
        return view
    }()
    
    
    fileprivate lazy var backBtn: UIButton = {
        var backBtn = UIButton()
        backBtn.setImage(UIImage(named: "ic_back"), for: UIControlState())
        backBtn.addTarget(self, action: #selector(CategoryController.backBtnDidClick), for: .touchUpInside)
        backBtn.imageView?.contentMode = .scaleAspectFit
        return backBtn
    }()

    
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 15)
        return titleLabel
    }()

    
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = 50
        var inset = tableView.contentInset
        // 50是tag图片高度
        inset.top = self.headerView.height+self.cellHeaderViewHeight
        tableView.contentInset = inset
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate var cellHeaderViewHeight: CGFloat = 70.0
    
    fileprivate var latestCellLayout = Array<HomePopbarLayout>()
}



extension CategoryController{
    
    fileprivate func pullToRefreshFootView() -> UIView{
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.center = CGPoint(x:self.view.center.x,y: 25)
        activityView.startAnimation()
        let footView = UIView()
        footView.origin = CGPoint.zero
        footView.size = CGSize(width: 50, height: 50)
        footView.addSubview(activityView)
        return footView
    }
    
    fileprivate func getData(_ page: Int=1){
        isRefreshing = true
        IFanService.shareInstance.getLatestLayout(APIConstant.category(categoryModel.type!, page), successHandle: { [weak self] (layoutArray) in
            guard self != nil else{
                return
            }
            if page == 1{
                self!.page = 1
                self!.latestCellLayout.removeAll()
            }
            
            layoutArray.forEach({ (layout) in
                self!.latestCellLayout.append(layout)
            })
            self!.page += 1
            self!.isRefreshing = false
            self!.tableView.reloadData()
            }) { (error) in
                print(error)
        }
        
    }
    
}

extension CategoryController{
    @objc fileprivate func backBtnDidClick(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
}


extension CategoryController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestCellLayout.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellModel = latestCellLayout[(indexPath as NSIndexPath).row].model
        if cellModel?.post_type == PostType.dasheng{
            let cell = cell as! HomeLatestTextCell
            cell.homePopbarLayout = latestCellLayout[(indexPath as NSIndexPath).row]
        }else if cellModel?.post_type == PostType.data{
            let cell = cell as! HomeLatestDateCell
            cell.popularLayout = latestCellLayout[(indexPath as NSIndexPath).row]
        }else{
            let cell = cell as! HomeLatestImageCell
            cell.popularLayout = latestCellLayout[(indexPath as NSIndexPath).row]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        let cellModel = latestCellLayout[(indexPath as NSIndexPath).row].model
        if cellModel?.post_type == PostType.dasheng{
             cell = HomeLatestTextCell.cellWithTableView(tableView)
        }else if cellModel?.post_type == PostType.data{
             cell = HomeLatestDateCell.cellWithTableView(tableView)
        }else{
             cell = HomeLatestImageCell.cellWithTableView(tableView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return latestCellLayout[(indexPath as NSIndexPath).row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = latestCellLayout[(indexPath as NSIndexPath).row].model
        self.navigationController?.pushViewController(DetailController(model: model!,navTitle: categoryModel.title), animated: true)
    }
}
