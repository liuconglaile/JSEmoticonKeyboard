//
//  ChatModel.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel
- (void)setUserType:(userType)userType {
    _userType = userType;
    
    _userHead = userType == userTypeMe ? @"接收者" : @"发送者";
    
    _userName = userType == userTypeMe ? @"接收者" : @"";
}

@end
