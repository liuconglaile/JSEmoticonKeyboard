//
//  JSDecoder.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSDecoder : NSObject
/**
 转码方法：将普通字符串转为富文本字符串 (包含图片、文字等)

 @param plainString 普通字符串
 @param font 展示字体大小
 @return 用于展示的富文本
 */
+ (NSMutableAttributedString *)js_decodeWithPlainString:(NSString *)plainString
                                                   font:(UIFont *)font;

@end
