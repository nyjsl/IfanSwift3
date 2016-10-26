//
//  StringExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/13.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation


extension String{
    
    var length: Int{
        return characters.count
    }
    
    func getSutiableString(_ pattern: String) -> [String]{
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count))
            var subArrary = [String]()
            for str in res{
                let subStr = (self as NSString).substring(with: str.range)
                subArrary.append(subStr)
            }
            return subArrary
        } catch  {
            print(error)
        }
        return [String]()
    }
}
