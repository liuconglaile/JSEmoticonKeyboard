//
//  JSEmoticonToolBarView.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/15.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonToolBarView.h"

@implementation JSEmoticonToolBarView
#pragma mark Instancetype
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor js_colorWithHexString:@"#FDFDFD"];
        
        [self addSubview:self.emoticonSendButton];
    }
    
    return self;
}

#pragma mark Lazy
- (UIButton *)emoticonSendButton {
    if (!_emoticonSendButton) {
        _emoticonSendButton = [[UIButton alloc] initWithFrame:CGRectMake(JSSCREEN_W - 80.0f,
                                                                         0.0f,
                                                                         80.0f,
                                                                         40.0f)];
        
        _emoticonSendButton.backgroundColor = [UIColor js_colorWithHexString:@"#29B8F7"];
        
        [_emoticonSendButton setTitle:@"发送"
                             forState:UIControlStateNormal];
        [_emoticonSendButton setTitle:@"发送"
                             forState:UIControlStateSelected];
        
        [_emoticonSendButton setTitleColor:[UIColor js_colorWithHexString:@"#FFFFFF"]
                                  forState:UIControlStateNormal];
        [_emoticonSendButton setTitleColor:[UIColor js_colorWithHexString:@"#FFFFFF"]
                                  forState:UIControlStateSelected];
        
        [_emoticonSendButton addTarget:self
                                action:@selector(emoticonSendButtonClick:)
                      forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _emoticonSendButton;
}

#pragma mark Action
- (void)emoticonSendButtonClick:(UIButton *)sender {
    if ([self.toolBarDelegate respondsToSelector:@selector(js_emoticonSendButtonClick)]) {
        [self.toolBarDelegate js_emoticonSendButtonClick];
    }
}

@end
