//
//  UIImageViewExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/13.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import YYWebImage

extension UIImageView{
    
    func extSetImage(_ imgUrl:URL!){
        self.yy_setImage(with: imgUrl, placeholder: UIImage(named: "place_holder_image"), options: [.setImageWithFadeAnimation,.progressiveBlur],completion: nil)
    }
    
    func extSetAvatar(_ avatarUrl: URL!) {
        self.yy_setImage(with: avatarUrl, placeholder: UIImage(named: "place_holder_avatar"), options: [.setImageWithFadeAnimation, .progressiveBlur], completion: nil)
    }
}
