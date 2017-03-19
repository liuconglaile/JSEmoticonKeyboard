//
//  JSEmoticonTopBarView.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/17.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonTopBarView.h"

#import "JSEmoticonKeyboardView.h"

static const CGFloat maxHeight = 90.0f;

@interface JSEmoticonTopBarView () <UITextViewDelegate>

@end

@implementation JSEmoticonTopBarView
#pragma mark Instancetype
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.emoticonTextView];
        [self addSubview:self.emoticonButton];
    }
    
    return self;
}

#pragma mark Lazy
- (UITextView *)emoticonTextView {
    if (!_emoticonTextView) {
        _emoticonTextView = [[UITextView alloc] init];
        
        _emoticonTextView.backgroundColor = [UIColor js_colorWithHexString:@"#FDFDFD"];
        
        _emoticonTextView.font = [UIFont systemFontOfSize:17.0f];
        
        _emoticonTextView.scrollEnabled = YES;
        
        _emoticonTextView.delegate = self;
        
        _emoticonTextView.returnKeyType = UIReturnKeySend;
        
        _emoticonTextView.layer.cornerRadius = 5.0f;
        _emoticonTextView.layer.borderWidth = 0.5f;
        _emoticonTextView.layer.borderColor = [UIColor js_colorWithHexString:@"#E3E3E5"].CGColor;
        
        _emoticonTextView.frame = CGRectMake(10.0f, 5.0f, JSSCREEN_W - 65.0f, 36.5f);
        
        [_emoticonTextView scrollRangeToVisible:NSMakeRange(_emoticonTextView.text.length, 1)];
    }
    
    return _emoticonTextView;
}

- (UIButton *)emoticonButton {
    if (!_emoticonButton) {
        _emoticonButton = [[UIButton alloc] init];
        
        _emoticonButton.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
        
        [_emoticonButton setImage:[UIImage imageNamed:@"Album_ToolViewEmotion"]
                         forState:UIControlStateNormal];
        [_emoticonButton setImage:[UIImage imageNamed:@"Album_ToolViewKeyboard"]
                         forState:UIControlStateSelected];
        
        [_emoticonButton addTarget:self
                            action:@selector(emoticonButtonClick:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        _emoticonButton.frame = CGRectMake(JSSCREEN_W - 45.0f, 5.0f, 36.5f, 36.5f);
        
        _emoticonButton.selected = NO;
    }
    
    return _emoticonButton;
}

#pragma mark Action
- (void)emoticonButtonClick:(UIButton *)sender {
    if ([self.topBarDelegate respondsToSelector:@selector(js_emoticonButtonClick:)]) {
        [self.topBarDelegate js_emoticonButtonClick:sender];
    }
}

- (void)resetEmoticonTopBar {
    [self textViewDidChange:_emoticonTextView];
}

- (void)updateEmoticonTopBar {
    CGRect tmepFrame = self.frame;
    
    tmepFrame.size = CGSizeMake(JSSCREEN_W, CGRectGetHeight(_emoticonTextView.frame) + 10.0f);
    
    self.frame = tmepFrame;
    
    _emoticonButton.frame = CGRectMake(JSSCREEN_W - 45.0f, CGRectGetHeight(self.frame) - 40.0f, 35.0f, 35.0f);
    
    if ([self.topBarDelegate respondsToSelector:@selector(js_emoticonTopBarChange)]) {
        [self.topBarDelegate js_emoticonTopBarChange];
    }
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        if ([self.topBarDelegate respondsToSelector:@selector(js_sendClick)]) {
            [self.topBarDelegate js_sendClick];
        }
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    CGFloat width = CGRectGetWidth(textView.frame);
    
    CGSize tempSize = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    CGRect tempFrame = textView.frame;
    CGRect maxFrame = textView.frame;
    
    maxFrame.size = CGSizeMake(width, maxHeight);
    tempFrame.size = CGSizeMake(width, tempSize.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        if (tempSize.height <= maxHeight) {
            textView.frame  = tempFrame;
            textView.scrollEnabled = NO;
        }
        else {
            textView.frame = maxFrame;
            textView.scrollEnabled = YES;
        }
        
        [self updateEmoticonTopBar];
    }];
}

@end
