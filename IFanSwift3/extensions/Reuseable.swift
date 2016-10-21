//
//  Resuable.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

public protocol Reuseable: class{
    
    static var reuseIdentifier: String{get}
    
}
extension Reuseable{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

/*
 Indentifier 参数为类名
*/
public extension UITableView{
    
    func dequeReuseableCell<T: Reuseable>() -> T?{
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T?
    }
    
}


public extension UICollectionView{
    
    func dequeReuseableCell<T: Reuseable>(_ forIndexPath: IndexPath)-> T{
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: forIndexPath) as! T
    }
    
    func dequeReuseable<T: Reuseable>(_ elementKind: String,forIndexPath: IndexPath) -> T{
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: forIndexPath) as! T
    }
    
    func registerClass<T: UICollectionViewCell>(_: T.Type) where T: Reuseable{
        return self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerClass<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind: String) where T: Reuseable {
        return self.register(T.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.reuseIdentifier)
    }
}

