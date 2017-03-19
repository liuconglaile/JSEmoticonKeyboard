//
//  ChatViewModel.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "ChatViewModel.h"

#import "JSDecoder.h"

@implementation ChatViewModel
- (void)setChat:(ChatModel *)chat {
    _chat = chat;
    
    CGFloat headWidth = 40.0f;
    CGFloat headHeight = 40.0f;
    
    CGFloat margin = 10.0f;
    
    CGFloat headX = chat.userType ? JSSCREEN_W - headWidth - margin : margin;
    
    _userHeadFrame = CGRectMake(headX, margin, headWidth, headHeight);
    
    CGRect userNameFrame = CGRectMake(CGRectGetMaxX(_userHeadFrame) + margin, CGRectGetMinY(_userHeadFrame), JSSCREEN_W - margin * 2 - headWidth, 20.0f);
    
    _userNameFrame = chat.userType == userTypeMe ? userNameFrame : CGRectZero;
    
    NSMutableAttributedString *attributedChatString = [JSDecoder js_decodeWithPlainString:chat.chatContent
                                                                                     font:[UIFont systemFontOfSize:17.0f]];
    
    _attributedChatString = attributedChatString;
    
    CGFloat AllMargin = 31.0f;
    
    CGSize maxsize = CGSizeMake(JSSCREEN_W - (margin * 4 + headWidth * 2) - AllMargin, MAXFLOAT);
    
    //  创建文本容器
    YYTextContainer *container = [YYTextContainer new];
    container.size = maxsize;
    container.maximumNumberOfRows = 0;
    
    //  生成排版结果
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container
                                                        text:_attributedChatString];
    
    CGFloat airX = chat.userType ? JSSCREEN_W - margin * 2 - headWidth - layout.textBoundingSize.width - AllMargin : margin * 2 + headWidth;
    
    self.airFrame = CGRectMake(airX, 35.0f, layout.textBoundingSize.width + 31.0f, layout.textBoundingSize.height + 16.0f);
    
    CGFloat contentX = chat.userType ? JSSCREEN_W - margin * 2 - headWidth - layout.textBoundingSize.width - 18.0f : margin * 2 + headWidth + 20.0f;
    
    _chatContentFrame = CGRectMake(contentX, 43.0f, layout.textBoundingSize.width, layout.textBoundingSize.height);
    
    _cellHeight = CGRectGetMaxY(_chatContentFrame) + margin;
}

@end
