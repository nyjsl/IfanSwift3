//
//  IFanService.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import Moya

class IFanService{
    
    static let shareInstance = IFanService()
    lazy var ifanProvider: MoyaProvider<APIConstant> = MoyaProvider<APIConstant>()
    
    fileprivate init(){}
    
    
    /*
     获取首页列表数据
    */
        func getLatestLayout(_ target: APIConstant,successHandle: ((Array<HomePopbarLayout>) -> Void)?,errorHandle:((Swift.Error) -> Void)?){
        
        ifanProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                do {
                    let json = try response.mapJSON() as? Dictionary<String,Any>
                    if let json = json{
                        if let content = json["data"] as? Array<Any>{
                            
                            DispatchQueue.global().async(execute: { 
                                let layoutArray = content.map({ (dict) -> HomePopbarLayout in
                                    return HomePopbarLayout(model: CommonModel(dict: dict as! NSDictionary))
                                })
                                
                                DispatchQueue.main.async(execute: { 
                                    if let success = successHandle{
                                        success(layoutArray)
                                    }
                                })
                                
                            })
                            
                        }
                    }
                    
                }catch{
                   print("出现异常")
                }
            case let .failure(error):
                if let handle = errorHandle{
                    handle(error)
                }
            }
        }
    }
    
    
    
    func getData<T:Initable>(_ target: APIConstant,t: T?,keys:Array<String>,successHandle: ((Array<T>) -> Void)? ,errorHandle: ((Swift.Error) -> Void)?){
        
        ifanProvider.request(target) { (result) in
            switch result{
            case let .success(response):
                do{
                    let json = try response.mapJSON() as? Dictionary<String,Any>
                    if let json = json{
                        if keys.count == 1{ //获取data数组
                            if let content = json[keys[0]] as? Array<Any>{
                                
                                DispatchQueue.global().async {
                                    let modelArray = content.map({ (dict) -> T in
                                        return T(dict: dict as!NSDictionary)
                                    })
                                    DispatchQueue.main.async {
                                        if let success = successHandle{
                                            success(modelArray)
                                        }
                                    }
                                }
                                
                            }else{
                                print("没有数据")
                            }
                            
                        }else if keys.count == 2{
                            if let content = json[keys[0]] as? Dictionary<String,Any>{
                                if let alls = content[keys[1]] as? Array<Any>{
                                    
                                    DispatchQueue.global().async {
                                        let  allsArray = alls.map({ (dict) -> T in
                                            return T(dict: dict as! NSDictionary)
                                        })
                                        
                                        DispatchQueue.main.async {
                                            if let success = successHandle{
                                                success(allsArray)
                                            }
                                        }
                                    }
                                    
                                }
                            }else{
                                print("没有数据")
                            }
                        }
                    }else{
                        print("没有数据")
                    }
                }catch{
                    print("出现异常")
                }
                
            case let .failure(error):
                if let handle = errorHandle{
                    handle(error)
                }
            }
        }
        
    }
    
}
