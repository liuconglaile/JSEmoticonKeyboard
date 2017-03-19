//
//  JSEmoticonToolBarView.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/15.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSEmoticonToolBarDelegate <NSObject>

- (void)js_emoticonSendButtonClick;

@end

@interface JSEmoticonToolBarView : UIView

@property (nonatomic, weak) id <JSEmoticonToolBarDelegate> toolBarDelegate;

@property (nonatomic, strong) UIButton *emoticonSendButton;

@end
