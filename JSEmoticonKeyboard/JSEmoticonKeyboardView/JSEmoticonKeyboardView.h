//
//  JSEmoticonKeyboardView.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/15.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSEmoticonTopBarView.h"

@protocol JSEmoticonKeyboardDelegate <NSObject>

- (void)js_emoticonKeyboardSendPlainString:(NSString *)plainString;
- (void)js_updateSuperView;

@end

@interface JSEmoticonKeyboardView : UIView

@property (nonatomic, weak) id <JSEmoticonKeyboardDelegate> emoticonKeyboardDelegate;

@property (nonatomic, strong) JSEmoticonTopBarView *emoticonTopBarView;

+ (instancetype)defaultEmoticonKeyboard;

+ (void)hideEmoticonKeyboardViewInView:(UIView *)superView;

@end
