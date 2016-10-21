//
//  APIConstant.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/9.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import Moya

public enum APIConstant{
    
    /**
     *  首页-热门（5条导航）参数 page, posts_per_page
     *
     *  @param Int    page请求的页数
     *
     */
    case home_hot_features(Int)
    
    /**
     *  首页-列表 每次请求12条
     *
     *  @param Int 参数page 分页数从1开始
     *
     */
    case home_latest(Int)
    
    /**
     *  快讯-列表
     *
     *  @param Int 分页数
     */
    case newsFlash_latest(Int)
    
    /**
     *  玩物志
     *
     *  @param Int 分页数
     */
    case playingZhi_latest(Int)
    
    /**
     *  AppSo
     *
     */
    case appSo_latest(Int)
    
    /**
     *  MainStore  从0开始
     */
    case mindStore_latest(Int)
    
    /**
     *  MindStore详情页的头像  id
     */
    case mindStore_Detail_Vote(String)
    
    /**
     *  MindStore详情页的评论  id offset
     */
    case mindStore_Detail_Comments(String, Int)
    
    /**
     *  分类
     */
    case category(CategoryName,Int)
    
    /**
     *  获得评论
     */
    case comments_latest(String)
}


/**
 分类类型
 
 - Video:      视频
 - ISeed:      ISeed
 - DaSheng:    大声
 - Shudu:      数读
 - Evaluation: 评测
 - Product:    参评
 - Car:        汽车
 - Business:   商业
 - Interview:  访谈
 - Picture:    图记
 - List:       清单
 */
public enum CategoryName {
    case video
    case iSeed
    case daSheng
    case shudu
    case evaluation
    case product
    case car
    case business
    case interview
    case picture
    case list
    
    /**
     获取分类名字
     */
    func getName() -> String {
        switch self {
        case .video:
            return "video-special"
        case .iSeed:
            return "iseed"
        case .daSheng:
            return "dasheng"
        case .shudu:
            return "data"
        case .evaluation:
            return "review"
        case .product:
            return "product"
        case .car:
            return "intelligentcar"
        case .business:
            return "business"
        case .interview:
            return "interview"
        case .picture:
            return "tuji"
        case .list:
            return "%E6%B8%85%E5%8D%95".removingPercentEncoding!
        }
    }
}


extension APIConstant: TargetType{
    
    
    fileprivate var appKey: String{
        return "sg5673g77yk72455af4sd55ea"
    }
    
    fileprivate var excerpt_length: Int{
        return 80
    }
    
    fileprivate var sign: String{
        return "be072a0fc0b7020836bae8777f2fbeca"
    }
    
    fileprivate var timeStamp: String{
        return Date.getCurrentTimeStamp()
    }
    
    
    fileprivate var post_type: String{
        switch self {
        case .home_hot_features(_),.home_latest(_):
            return "post%2Cnews%2Cdasheng%2Cdata".removingPercentEncoding!
        case .newsFlash_latest(_):
            return "buzz"
        case .playingZhi_latest(_):
            return "coolbuy"
        case .appSo_latest(_):
            return "app"
        case let .category(type, _):
            return type.getName()
        default:
            return ""
        }
    }
    
    fileprivate var action: String{
        switch self {
        case .home_hot_features(_):
            return "hot_featurs"
        case .comments_latest(_):
            return "ifr_m_get_mobile_comments"
        default:
          return "ifr_m_latest"
        }
    }
    
    fileprivate var posts_per_page: Int {
        switch self {
        case .home_hot_features(_):
            return 5
        default:
            return 12
        }
    }

    
    
    public var baseURL: URL {
        switch self {
        case .mindStore_latest(_),.mindStore_Detail_Vote(_),.mindStore_Detail_Comments(_, _):
            return URL(string: "https://sso.ifanr.com/api/v1.2/mind/")!
        default:
             return URL(string: "https://www.ifanr.com/api/v3.0/")!
        }
    }
    public var path: String {
        switch self {
        case let .mindStore_Detail_Vote(id):
            return "vote/\(id)"
        case .mindStore_Detail_Comments(_, _):
            return "comment/"
        default:
            return ""
        }
    }
    public var method: Moya.Method {
        return Moya.Method.get
        
    }
    public var parameters: [String: Any]? {
        switch self {
        //首页热门
        case let .home_hot_features(page):
            return getParameters(page)
        //首页列表
        case let .home_latest(page):
            return getParameters(page)
        //快讯列表
        case let .newsFlash_latest(page):
            return getParameters(page)
        //玩物志列表
        case let .playingZhi_latest(page):
            return getParameters(page)
        case let .appSo_latest(page):
            return getParameters(page)
        case let .mindStore_latest(page):
            return ["look_back_days":page as Any,"limit":60 as Any]
        case let .comments_latest(id):
            return ["action":action as Any, "appKey": appKey as Any, "post_id":id as Any ,"sign": sign as Any, "timestamp": timeStamp as Any]
        case let .category(type, page):
            if type == CategoryName.daSheng || type == CategoryName.shudu || type == CategoryName.picture{
                return getParameters(page)
            }else{
                return getParamatersIncludeCategotyType(page, type: type.getName())
            }
        case let .mindStore_Detail_Comments(id, offset):
            return ["mind": id as Any, "limit": 12 as Any, "offset": offset as Any]
        default:
            return nil
        }
    }
    
    fileprivate func getParameters(_ page: Int) -> [String:Any]?{
        return ["action":action as AnyObject,"appkey":appKey as AnyObject,"excerpt_length":excerpt_length as AnyObject,"sign":sign as AnyObject,"timestamp":timeStamp as AnyObject,
            "page":page as AnyObject,"posts_per_page":posts_per_page as AnyObject,"post_type":post_type as AnyObject]
    }
    
    fileprivate func getParamatersIncludeCategotyType(_ page: Int,type: String) -> [String:Any]?{
        if var dict = getParameters(page){
            dict["category_name"] = type as AnyObject?
            return dict
        }
        return nil
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var multipartBody: [MultipartFormData]? {
        return nil
    }
    
    public var task: Task{
        return .request
    }
}




