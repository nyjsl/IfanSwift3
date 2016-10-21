//
//  BottomToolsBar.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import Foundation


protocol ToolBarDelegate {
    func editCommentDidClick()
    func praiseButtonDidClick()
    func shareButtonDidClick()
    func commentButtonDidClick()

}

class BottomToolsBar: UIView{
    
    var delegate: ToolBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.praizeButton)
        self.addSubview(self.shareButton)
        self.addSubview(self.commentButton)
        self.addSubview(self.editCommentTextField)
        self.addSubview(self.redLineView)
        
        self.backgroundColor = UIColor.white
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func praiseButtonAction(){
        self.delegate?.praiseButtonDidClick()
    }
    
    @objc fileprivate func editCommentAction(){
        self.delegate?.editCommentDidClick()
    }
    
    @objc fileprivate func shareButtonAction() {
        self.delegate?.shareButtonDidClick()
    }
    
    @objc fileprivate func commentButtonAction() {
        self.delegate?.commentButtonDidClick()
    }

    
    //MARK -------getter setter
    
    fileprivate lazy var redLineView: UIView = {
        let readLineView: UIView = UIView(frame:CGRect(x: 20,y: 12.5,width: 2,height: 25))
        readLineView.backgroundColor = UIColor.red
        return readLineView
    }()
    //编辑评论的框
    fileprivate lazy var editCommentTextField: UITextField = {
        let textField: UITextField = UITextField(frame: CGRect(x: self.redLineView.x+12,y: 12.5,width: 100,height: 25))
        textField.font = UIFont.customFont_FZLTZCHJW(fontSize: 12)
        textField.placeholder = "您有什么看法呢?"
        textField.contentVerticalAlignment = .center
        textField.addTarget(self, action: #selector(editCommentAction), for: .touchUpInside)
        return textField
        
    }()
    
    lazy var praizeButton:UIButton = {
        let frame = CGRect(x: UIConstant.SCREEN_WIDTH-155, y: 12.5, width: 50, height: 30)
        let button: UIButton = UIButton(frame: frame)
        button.setImage(UIImage(imageLiteralResourceName: "ic_comment_bar_like_false"), for: UIControlState())
        button.setImage((UIImage(imageLiteralResourceName: "ic_comment_bar_like_true")), for: .selected)
        button.setTitle("点赞(11)", for: UIControlState())
        button.setTitleColor(UIColor.gray, for: UIControlState())
        button.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(-12, 16, 0, 16)
        button.titleEdgeInsets = UIEdgeInsetsMake(button.currentImage!.size.height-9,-button.currentImage!.size.width,0, 0)
        button.addTarget(self, action: #selector(praiseButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// 分享 button
    lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton(frame: CGRect(x: UIConstant.SCREEN_WIDTH-95, y: 12.5, width: 30, height: 30))
        shareButton.setImage(UIImage(imageLiteralResourceName: "ic_comment_bar_share"), for: UIControlState())
        shareButton.setTitle("分享", for: UIControlState())
        shareButton.setTitleColor(UIColor.gray, for: UIControlState())
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        shareButton.imageEdgeInsets = UIEdgeInsetsMake(-16, 7, 0, 7)
        shareButton.titleEdgeInsets = UIEdgeInsetsMake(shareButton.currentImage!.size.height-12.5, -shareButton.currentImage!.size.width, 0, 0)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        return shareButton
    }()
    /// 评论 button
    internal lazy var commentButton: UIButton = {
        let commentButton: UIButton = UIButton(frame: CGRect(x: UIConstant.SCREEN_WIDTH-45, y: 12.5, width: 30, height: 30))
        commentButton.setImage(UIImage(imageLiteralResourceName: "ic_comment"), for: UIControlState())
        commentButton.setTitle("评论", for: UIControlState())
        commentButton.setTitleColor(UIColor.gray, for: UIControlState())
        commentButton.titleLabel?.font  = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        commentButton.imageView?.contentMode = .scaleAspectFit
        commentButton.imageEdgeInsets = UIEdgeInsetsMake(-12, 6.5, 0, 6.5)
        commentButton.titleEdgeInsets = UIEdgeInsetsMake(commentButton.currentImage!.size.height-10, -commentButton.currentImage!.size.width, 0, 0)
        commentButton.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
        return commentButton
    }()

    
    
}

