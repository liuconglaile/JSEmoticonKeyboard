//
//  ChatViewModel.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatModel.h"

@interface ChatViewModel : NSObject

@property(nonatomic, strong) ChatModel *chat;
@property(nonatomic, strong) NSMutableAttributedString *attributedChatString;

@property(nonatomic, assign) CGRect userHeadFrame;
@property(nonatomic, assign) CGRect userNameFrame;
@property(nonatomic, assign) CGRect chatContentFrame;
@property(nonatomic, assign) CGRect airFrame;

@property(nonatomic, assign) CGFloat cellHeight;

@end
