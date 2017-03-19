//
//  JSEmoticonTopBarView.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/17.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSEmoticonTopBarDelegate <NSObject>

- (void)js_emoticonButtonClick:(UIButton *)sender;
- (void)js_emoticonTopBarChange;
- (void)js_sendClick;

@end

@interface JSEmoticonTopBarView : UIView

@property (nonatomic, weak) id <JSEmoticonTopBarDelegate> topBarDelegate;

@property (nonatomic, strong) UITextView *emoticonTextView;
@property (nonatomic, strong) UIButton *emoticonButton;

@property (nonatomic, assign) CGFloat currentKeyboardHeight;

- (void)resetEmoticonTopBar;

@end
