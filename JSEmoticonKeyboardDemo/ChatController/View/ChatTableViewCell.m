//
//  ChatTableViewCell.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "ChatTableViewCell.h"

#import "JSEmoticonKeyboardView.h"

@interface ChatTableViewCell ()

@property (nonatomic, strong) UIImageView *userHeadImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) YYLabel *chatContentLabel;
@property (nonatomic, strong) UIButton *airButton;

@end

@implementation ChatTableViewCell {
    JSEmoticonKeyboardView *_keyboard;
}

#pragma mark Instancetype
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor js_colorWithHexString:@"#EEEEEE"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _keyboard = [JSEmoticonKeyboardView defaultEmoticonKeyboard];
        
        [self createSubviews];
        [self createLongPressGestureRecognizer];
    }
    
    return self;
}

#pragma mark Create Subviews
- (void)createSubviews {
    [self addSubview:self.userHeadImageView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.airButton];
    [self addSubview:self.chatContentLabel];
}

#pragma mark Create LongPressGestureRecognizer
- (void)createLongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                             action:@selector(showMenuController:)];
    [_airButton addGestureRecognizer:longPressGestureRecognizer];
}

#pragma mark Lazy
- (UIImageView *)userHeadImageView {
    if (!_userHeadImageView) {
        _userHeadImageView = [[UIImageView alloc] init];
        
        _userHeadImageView.backgroundColor = [UIColor js_colorWithHexString:@"#EEEEEE"];
        
        _userHeadImageView.layer.cornerRadius = 20.0f;
        _userHeadImageView.layer.masksToBounds = YES;
        
        _userHeadImageView.userInteractionEnabled = YES;
    }
    
    return _userHeadImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        
        _userNameLabel.font = [UIFont systemFontOfSize:14.0f];
        
        _userNameLabel.textColor = [UIColor js_colorWithHexString:@"#8C8C8C"];
        
        _userNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return _userNameLabel;
}

- (YYLabel *)chatContentLabel {
    if (!_chatContentLabel) {
        _chatContentLabel = [[YYLabel alloc] init];
        
        _chatContentLabel.numberOfLines = 0;
        
        _chatContentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
                
        _chatContentLabel.userInteractionEnabled = NO;
    }
    
    return _chatContentLabel;
}

- (UIButton *)airButton {
    if (!_airButton) {
        _airButton = [[UIButton alloc] init];
        //  shadowColor 阴影颜色
        _airButton.layer.shadowColor = [UIColor js_colorWithHexString:@"#000000"].CGColor;
        //  shadowOffset 阴影偏移, +x 向右偏移, +y 向下偏移, 默认 (0.0f, 0.0f), 与 shadowRadius 配合使用
        _airButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        //  阴影透明度, 默认 0.1f
        _airButton.layer.shadowOpacity = 0.1f;
        //  阴影半径, 默认 4.0f
        _airButton.layer.shadowRadius = 4.0f;
    }
    
    return _airButton;
}

#pragma mark Action
- (void)setChatView:(ChatViewModel *)chatView {
    _chatView = chatView;
    
    _userHeadImageView.frame = chatView.userHeadFrame;
    _userNameLabel.frame = chatView.userNameFrame;
    _chatContentLabel.frame = chatView.chatContentFrame;
    _airButton.frame = chatView.airFrame;

    _userHeadImageView.image = [UIImage imageNamed:chatView.chat.userHead];
    _userNameLabel.text = chatView.chat.userName;

    NSString *normalImageName = chatView.chat.userType == userTypeOther ? @"Chat_Send_Normal" : @"Chat_Receive_Normal";
    NSString *selectedImageName = chatView.chat.userType == userTypeOther ? @"Chat_Send_Selected" : @"Chat_Receive_Selected";
    
    UIImage *normalImage = [self resizebleImageWithName:normalImageName];
    UIImage *selectedImage = [self resizebleImageWithName:selectedImageName];
    
    [_airButton setBackgroundImage:normalImage
                          forState:UIControlStateNormal];
    [_airButton setBackgroundImage:selectedImage
                          forState:UIControlStateHighlighted];
    
    _chatContentLabel.attributedText = chatView.attributedChatString;
}

- (void)showMenuController:(UIGestureRecognizer *)gestureRecognizer {
    UIMenuController *menuController = [UIMenuController sharedMenuController];

    [self becomeFirstResponder];
        
    UIMenuItem *menuItemWithCopy = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                              action:@selector(copyChat)];
    UIMenuItem *menuItemWithTranspond = [[UIMenuItem alloc] initWithTitle:@"转发"
                                                                   action:@selector(transpondChat)];
    UIMenuItem *menuItemWithCollect = [[UIMenuItem alloc] initWithTitle:@"收藏"
                                                                 action:@selector(collectChat)];
    UIMenuItem *menuItemWithRecall = [[UIMenuItem alloc] initWithTitle:@"撤回"
                                                                action:@selector(recallChat)];
    UIMenuItem *menuItemWithDelete = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                                action:@selector(deleteChat)];
    
    [menuController setMenuItems:@[
                                   menuItemWithCopy,
                                   menuItemWithTranspond,
                                   menuItemWithCollect,
                                   menuItemWithRecall,
                                   menuItemWithDelete
                                   ]];
        
    CGRect rect = [_airButton convertRect:_airButton.bounds
                                   toView:self.superview];
        
    CGFloat menuItemY = 0.0f;
        
    if (rect.origin.y < 64.0f) {
        menuItemY = CGRectGetMaxY(_airButton.frame) - 6.0f;
            
        menuController.arrowDirection = UIMenuControllerArrowUp;
    }
    else {
        menuItemY = _airButton.js_top + 6.0f;
            
        menuController.arrowDirection = UIMenuControllerArrowDown;
    }
        
    CGRect menuLocation = CGRectMake(_airButton.center.x, menuItemY, 0.0f, 0.0f);
        
    [menuController setTargetRect:menuLocation
                           inView:self];
        
    [menuController setMenuVisible:YES
                          animated:YES];
}

- (void)copyChat {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = _chatView.chat.chatContent;
}

- (void)transpondChat {
    NSLog(@"转发");
}

- (void)collectChat {
    NSLog(@"收藏");
}

- (void)recallChat {
    NSLog(@"撤回");
}

- (void)deleteChat {
    if (self.deleteChatBlock) {
        self.deleteChatBlock(_chatView);
    }
}

#pragma mark 私有方法
- (UIImage *)resizebleImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(width * 0.5f, height * 0.5f, width * 0.5f, height * 0.5f)
                                        resizingMode:UIImageResizingModeStretch];
    
    return image;
}

- (BOOL)canPerformAction:(SEL)action
              withSender:(id)sender {
    if (action == @selector(copyChat) || action == @selector(transpondChat) || action == @selector(collectChat) || action == @selector(recallChat) || action == @selector(deleteChat)){
        return YES;
    }
    
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
