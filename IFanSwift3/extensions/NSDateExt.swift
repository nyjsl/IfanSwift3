//
//  NSDateExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/12.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

extension Date{
    //获取今天日期
    static func today() -> String{
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    //判断是否是今天
    static func isToday(_ dateStr: String) -> Bool{
        return dateStr == today()
    }
    
    static func getTimeIntervalFromNow(_ dateStr: String) -> TimeInterval{
        
        guard dateStr.characters.count > 0 else{
            return 0
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Beijing")
        let date = dateFormatter.date(from: dateStr)
        return (date?.timeIntervalSinceNow)!
        
    }
    
    static func getCommonExpresionOfDate(_ dateStr: String) -> String{
        
        var resultStr = ""
        
        let timeIntervalHour = (-1*getTimeIntervalFromNow(dateStr))/60/60
        if timeIntervalHour<1{
            resultStr = "\(timeIntervalHour*60)分钟前"
        }else if timeIntervalHour<24{
            resultStr = "\(Int(timeIntervalHour))小时前"
        }else if timeIntervalHour<48{
            resultStr = "昨天 \(getStrByRange(dateStr,start: 11,end: 17))"
        }else if timeIntervalHour<72{
            resultStr = "前天 \(getStrByRange(dateStr,start: 11,end: 17))"
        }else{
            let array: Array = dateStr.components(separatedBy: " ")
            
            if(array.count>0){
                let monthDayArray: Array = array[0].components(separatedBy: "-")
                resultStr = monthDayArray[1]+"月"+monthDayArray[2]+"日"
                resultStr += getStrByRange(array[1], start: 0, end: 5)
            }
            
            
            
        }
        return resultStr
        
    }
    
    static func getStrByRange(_ dateStr: String,start:Int,end:Int) ->String{
        guard dateStr.characters.count > end-1 else{
            return ""
        }
        let indexStart = dateStr.characters.index(dateStr.startIndex, offsetBy: start)
        let indexEnd = dateStr.characters.index(dateStr.startIndex, offsetBy: end)
        let indexRange = Range(indexStart..<indexEnd)
        return dateStr.substring(with: indexRange)
    }
    
    /**
     将yyyy-MM-dd HH:mm:ss装换成MM月dd日 HH:mm
     
     - parameter timeStamp: 时间戳
     */
    static func getDate(_ date: String) -> String{
        let lastFormatter = DateFormatter()
        lastFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let lastDate = lastFormatter.date(from: date)
        
        let currFormatter = DateFormatter()
        currFormatter.dateFormat = "MM月dd日 HH:mm"
        return currFormatter.string(from: lastDate!)
    }


    static func getCurrentTimeStamp() -> String{
        let timeStamp: String = "\(Int64(floor(Date().timeIntervalSince1970*1000)))"
        return timeStamp
    }
    
    static func isEarlier(_ dateFirst: String , dateSecond: String) -> Bool{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.date(from: dateFirst)
        let date2 = dateFormatter.date(from: dateSecond)
        return date1?.compare(date2!) == ComparisonResult.orderedAscending
    }
    
    
}
