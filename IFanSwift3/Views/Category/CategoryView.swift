//
//  CategoryView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/9.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

import UIKit




class CategoryView: UIView{
    
    typealias CoverBtnClickCallback = ()->Void
    
    typealias ItemDidClickCallback = (_ collectionView: UICollectionView,_ indexPath: IndexPath)->Void

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(coverButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        label.origin = CGPoint.zero
        label.size = CGSize(width: self.width, height: 20)
        label.text = "更多栏目"
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    
    }()
    
    @objc fileprivate func coverBtnDidClick(){
        if let callBack = coverBtnClickCallback{
            callBack()
        }
    }
    
    fileprivate var coverBtnClickCallback: CoverBtnClickCallback?
    fileprivate var itemDidClickCallback: ItemDidClickCallback?
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.headerReferenceSize = CGSize(width: self.width, height: 70)
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        let itemWidth = (UIConstant.SCREEN_WIDTH-4*UIConstant.UI_MARGIN_10)/3
        let itemHeight = itemWidth*81/100
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.width, height: self.height*0.8), collectionViewLayout: collectionViewLayout)
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.white
        collectionView.registerClass(CategrotyViewCell.self)
        collectionView.registerClass(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate lazy var coverButton: UIButton = {
        let coverButton = UIButton()
        coverButton.origin = CGPoint(x: 0, y: self.collectionView.frame.maxY)
        coverButton.size = CGSize(width: self.width, height: self.height-self.collectionView.frame.maxY)
        coverButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        coverButton.addTarget(self, action: #selector(CategoryView.coverBtnDidClick), for: .touchDown)
        return coverButton
    }()
    
}

extension CategoryView{
    
    func coverBtnClick(_ callBack: @escaping CoverBtnClickCallback){
        self.coverBtnClickCallback = callBack
    }
    
    func itemBtnDidClick(_ callBack: @escaping ItemDidClickCallback){
        self.itemDidClickCallback  = callBack
    }
}

extension CategoryView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CategrotyViewCell
        cell.model = categoryModelArray[(indexPath as NSIndexPath).row]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseableCell(indexPath) as CategrotyViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        indexPath
        
        let headerView = collectionView.dequeReuseable(UICollectionElementKindSectionHeader, forIndexPath: indexPath) as CategoryHeaderView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callBack = itemDidClickCallback {
            callBack(collectionView, indexPath)
        }
    }
    
}

