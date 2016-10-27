//
//  MindStoreVoteModel.swift
//  IFanSwift3
//
//  Created by 魏星 on 2016/10/27.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

struct VotedUser {
    var avatar_url: String!
    var company: String!
    var email: String!
    var id: Int64!
    var lime_home_url: String!
    var position: String!
    
    init(dict: NSDictionary) {
        self.avatar_url = dict["avatar_url"] as? String ?? ""
        self.company = dict["company"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.id = dict["id"] as? Int64 ?? 0
        self.lime_home_url = dict["lime_home_url"] as? String ?? ""
        self.position = dict["position"] as? String ?? ""
    }
}


struct MindStoreVoteModel: Initable {
    var id: Int64!
    var resource_uri: String!
    var share_count: Int64!
    var voted: Bool!
    var votedUserArray = Array<VotedUser>()
    
    init(dict: NSDictionary) {
        self.id = dict["id"] as? Int64 ?? 0
        self.resource_uri = dict["resource_uri"] as? String ?? ""
        self.share_count = dict["share_count"] as? Int64 ?? 0
        self.voted = dict["voted"] as? Bool ?? false
        
        if let votedUserArray = dict["voted_user"] as? Array<NSDictionary> {
            self.votedUserArray = votedUserArray.map { (dict) -> VotedUser in
                return VotedUser(dict: dict)
            }
        }
    }
}
