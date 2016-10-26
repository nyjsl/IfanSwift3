//
//  MindStoreModel.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/26.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
struct CreatedByModel {
    var avatar_url: String!
    var company: String!
    var email: String!
    var id: String!
    var lime_home_url: String!
    var nickname: String!
    var position: String!
    var wechat_screenname: String!
    
}

struct RelatedImageModel {
    var link: String!
    var resource_uri: String!
    var title: String!
}

struct MindStoreModel: Initable {
    var id: Int64!
    var comment_count: String!
    var comment_order: String!
    var created_at: String!
    var is_auto_refresh: String!
    var is_producer: String!
    var link: String!
    var priority: String!
    var producer_participated: String!
    var resource_uri: String!
    var share_count: String!
    var tagline: String!
    var title: String!
    var vote_count: NSNumber!
    var vote_user_count: NSNumber!
    var voted: Int64!
    
    var createdByModel: CreatedByModel! = CreatedByModel()
    var relatedImageModelArr: [RelatedImageModel] = Array()
    
    init(dict: NSDictionary) {
        self.id = dict["id"] as? Int64 ?? 0
        self.comment_count  = dict["comment_count"] as? String ?? ""
        self.comment_order  = dict["comment_order"] as? String ?? ""
        self.created_at     = dict["created_at"] as? String ?? ""
        self.is_auto_refresh = dict["is_auto_refresh"] as? String ?? ""
        self.is_producer    = dict["is_producer"] as? String ?? ""
        
        self.link       = dict["link"] as? String ?? ""
        self.priority   = dict["priority"] as? String ?? ""
        self.producer_participated = dict["producer_participated"] as? String ?? ""
        self.resource_uri   = dict["resource_uri"] as? String ?? ""
        self.share_count    = dict["share_count"] as? String ?? ""
        self.tagline    = dict["tagline"] as? String ?? ""
        self.title      = dict["title"] as? String ?? ""
        self.vote_count = dict["vote_count"] as? NSNumber ?? 0
        self.vote_user_count = dict["vote_user_count"] as? NSNumber ?? 0
        self.voted = dict["voted"] as? Int64 ?? 0
        
        if let createByDic = dict["created_by"] as! NSDictionary? {
            self.createdByModel.avatar_url  = createByDic["avatar_url"] as? String ?? ""
            self.createdByModel.company     = createByDic["company"] as? String ?? ""
            self.createdByModel.email       = createByDic["email"] as? String ?? ""
            self.createdByModel.id          = createByDic["id"] as? String ?? ""
            self.createdByModel.lime_home_url = createByDic["lime_home_url"] as? String ?? ""
            self.createdByModel.nickname = createByDic["nickname"] as? String ?? ""
            self.createdByModel.position = createByDic["position"] as? String ?? ""
            self.createdByModel.wechat_screenname = createByDic["wechat_screenname"] as? String ?? ""
        }
        
        if let tmp = dict["related_image"] {
            for item in (tmp as? NSArray)! {
                if let itemDic: NSDictionary = item as? NSDictionary {
                    var model: RelatedImageModel = RelatedImageModel()
                    model.link  = itemDic["link"] as! String
                    model.title = itemDic["title"] as! String
                    model.resource_uri = itemDic["resource_uri"] as! String
                    self.relatedImageModelArr.append(model)
                }
            }
        }
        //        var model: RelatedImageModel = RelatedImageModel()
        //        model.link = "http://media.ifanrusercontent.com/media/user_files/lime/fc/0f/fc0f1fa3b6eb1b3f8e6c2e2666415e1acaea6387-137691a83047904eca6b05d23d91cda63702b847.jpg"
        //        self.relatedImageModelArr.append(model)
        //        var model1: RelatedImageModel = RelatedImageModel()
        //        model1.link = "http://media.ifanrusercontent.com/media/user_files/lime/fc/0f/fc0f1fa3b6eb1b3f8e6c2e2666415e1acaea6387-137691a83047904eca6b05d23d91cda63702b847.jpg"
        //        self.relatedImageModelArr.append(model1)
    }
}
