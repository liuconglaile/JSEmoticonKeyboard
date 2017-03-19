//
//  ChatModel.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    userTypeMe,
    userTypeOther,
} userType;

@interface ChatModel : NSObject

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *userHead;
@property(nonatomic, copy) NSString *chatContent;

@property(nonatomic, assign) NSInteger userId;
@property(nonatomic, assign) userType userType;

@end
