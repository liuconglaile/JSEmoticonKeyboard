//
//  ChatTableViewCell.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "ChatTableViewCell.h"

@interface ChatTableViewCell ()

@property (nonatomic, strong) UIImageView *userHeadImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) YYLabel *chatContentLabel;
@property (nonatomic, strong) UIButton *airButton;

@end

@implementation ChatTableViewCell
#pragma mark Instancetype
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor js_colorWithHexString:@"#EEEEEE"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubviews];
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

#pragma mark Lazy
- (UIImageView *)userHeadImageView {
    if (!_userHeadImageView) {
        _userHeadImageView = [[UIImageView alloc] init];
        
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

    NSString *normalImageName = chatView.chat.userType == userTypeOther ? @"chat_send_nor" : @"chat_receive_nor";
    NSString *selectedImageName = chatView.chat.userType == userTypeOther ? @"chat_send_p" : @"chat_receive_p";
    
    UIImage *normalImage = [self resizebleImageWithName:normalImageName];
    UIImage *selectedImage = [self resizebleImageWithName:selectedImageName];
    
    [_airButton setBackgroundImage:normalImage
                          forState:UIControlStateNormal];
    [_airButton setBackgroundImage:selectedImage
                          forState:UIControlStateHighlighted];
    
    _chatContentLabel.attributedText = chatView.attributedChatString;
}

- (UIImage *)resizebleImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(width * 0.5f, height * 0.5f, width * 0.5f, height * 0.5f)
                                        resizingMode:UIImageResizingModeStretch];
    
    return image;
}

@end
