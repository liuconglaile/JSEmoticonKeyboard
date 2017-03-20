//
//  JSEmoticonKeyboardView.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/15.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonKeyboardView.h"

#import "JSEmoticonCollectionView.h"
#import "JSEmoticonCollectionViewFlowLayout.h"

#import "JSEmoticonPageView.h"
#import "JSEmoticonToolBarView.h"

#import "JSEmoticonTextAttachment.h"

#import "NSAttributedString+JSCategory.h"

@interface JSEmoticonKeyboardView () <JSEmoticonTopBarDelegate, JSEmoticonCollectionDelegate, JSEmoticonToolBarDelegate>

@property (nonatomic, strong) JSEmoticonCollectionView *emoticonCollectionView;
@property (nonatomic, strong) JSEmoticonCollectionViewFlowLayout *emoticonCollectionViewFlowLayout;

@property (nonatomic, strong) JSEmoticonPageView *emoticonPageView;

@property (nonatomic, strong) JSEmoticonToolBarView *emoticonToolBarView;

@property (nonatomic, assign) CGFloat emoticonSize;

@property (nonatomic, copy) NSDictionary *emoticonDictionary;

@end

@implementation JSEmoticonKeyboardView
#pragma mark Instancetype
+ (instancetype)defaultEmoticonKeyboard {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;

}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self method];
    }
    
    return self;
}

+ (void)hideEmoticonKeyboardViewInView:(UIView *)superView {
    __block JSEmoticonKeyboardView *emoticonKeyboardView;
    
    [superView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[JSEmoticonKeyboardView class]]) {
            emoticonKeyboardView = (JSEmoticonKeyboardView *)obj;
            *stop = YES;
        }
    }];
    
    emoticonKeyboardView.emoticonTopBarView.emoticonButton.selected = NO;
    
    if ([emoticonKeyboardView.emoticonTopBarView.emoticonTextView isFirstResponder]) {
        [emoticonKeyboardView.emoticonTopBarView.emoticonTextView resignFirstResponder];
    }
    
    [emoticonKeyboardView hideEmoticonKeyboardView];
}

#pragma mark Method
- (void)method {
    [self createSubviews];
    [self createEmoticonKeyboardView];
    [self setupNotification];
}

- (void)createSubviews {
    [self addSubview:self.emoticonTopBarView];
    [self addSubview:self.emoticonCollectionView];
    [self addSubview:self.emoticonPageView];
    [self addSubview:self.emoticonToolBarView];
}

- (void)createEmoticonKeyboardView {
    self.backgroundColor = [UIColor js_colorWithHexString:@"#E3E3E5"];
    
    self.userInteractionEnabled = YES;
    
    CGFloat emoticonKeyboardViewHeight = _emoticonTopBarView.js_height + _emoticonCollectionView.js_height + _emoticonPageView.js_height + _emoticonToolBarView.js_height;
    
    self.frame = CGRectMake(0.0f,
                            JSSCREEN_H - _emoticonTopBarView.js_height,
                            JSSCREEN_W,
                            emoticonKeyboardViewHeight);
}

- (void)showEmoticonKeyboardView {
    self.js_height = _emoticonTopBarView.js_height + _emoticonCollectionView.js_height + _emoticonPageView.js_height + _emoticonToolBarView.js_height;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.js_top = JSSCREEN_H - self.js_height;
        
        _emoticonTopBarView.currentKeyboardHeight = self.js_height - _emoticonTopBarView.js_height;
    }];
}

- (void)hideEmoticonKeyboardView {
    [UIView animateWithDuration:0.25f animations:^{
        self.js_top = JSSCREEN_H - _emoticonTopBarView.js_height;
    }];
    
    [self changeSuperView];
}

#pragma mark Lazy
- (JSEmoticonTopBarView *)emoticonTopBarView {
    if (!_emoticonTopBarView) {
        _emoticonTopBarView = [[JSEmoticonTopBarView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                     0.0f,
                                                                                     JSSCREEN_W,
                                                                                     46.5f)];
        
        _emoticonTopBarView.topBarDelegate = self;
    }
    
    return _emoticonTopBarView;
}

- (JSEmoticonCollectionViewFlowLayout *)emoticonCollectionViewFlowLayout {
    if (!_emoticonCollectionViewFlowLayout) {
        _emoticonCollectionViewFlowLayout = [[JSEmoticonCollectionViewFlowLayout alloc] init];
    }
    
    return _emoticonCollectionViewFlowLayout;
}

- (JSEmoticonCollectionView *)emoticonCollectionView {
    if (!_emoticonCollectionView) {
        _emoticonCollectionView = [[JSEmoticonCollectionView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                             _emoticonTopBarView.js_height + 1.0f,
                                                                                             JSSCREEN_W,
                                                                                             3.0f * JSSCREEN_W / 7.0f)
                                                             collectionViewLayout:self.emoticonCollectionViewFlowLayout];
        
        _emoticonCollectionView.emoticonDelegate = self;
    }
    
    return _emoticonCollectionView;
}

- (JSEmoticonPageView *)emoticonPageView {
    if (!_emoticonPageView) {
        _emoticonPageView = [[JSEmoticonPageView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                 _emoticonCollectionView.js_bottom,
                                                                                 JSSCREEN_W,
                                                                                 20.0f)];
    }
    
    return _emoticonPageView;
}

- (JSEmoticonToolBarView *)emoticonToolBarView {
    if (!_emoticonToolBarView) {
        _emoticonToolBarView = [[JSEmoticonToolBarView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                       _emoticonPageView.js_bottom,
                                                                                       JSSCREEN_W,
                                                                                       40.0f)];
        
        _emoticonToolBarView.toolBarDelegate = self;
    }
    
    return _emoticonToolBarView;
}

- (NSDictionary *)emoticonDictionary {
    if (!_emoticonDictionary) {
        NSString *pathURL = [[NSBundle mainBundle] pathForResource:@"Emoticon"
                                                            ofType:@"plist"];
        _emoticonDictionary = [NSDictionary dictionaryWithContentsOfFile:pathURL];
    }
    
    return _emoticonDictionary;
}

#pragma mark Delegate
- (void)js_emoticonButtonClick:(UIButton *)sender {
    if (!sender.selected) {
        if ([_emoticonTopBarView.emoticonTextView isFirstResponder]) {
            [_emoticonTopBarView.emoticonTextView resignFirstResponder];
        }

        _emoticonTopBarView.emoticonButton.selected = YES;
        
        [self showEmoticonKeyboardView];
    }
    else {
        [_emoticonTopBarView.emoticonTextView becomeFirstResponder];
        
        _emoticonTopBarView.emoticonButton.selected = NO;
    }
    
    [self changeSuperView];
}

- (void)js_emoticonTopBarChange {
    CGRect tempFrame = self.frame;
    
    _emoticonCollectionView.js_top = _emoticonTopBarView.js_height + 1.0f;
    _emoticonPageView.js_top = _emoticonCollectionView.js_bottom;
    _emoticonToolBarView.js_top = _emoticonPageView.js_bottom;
    
    if (_emoticonTopBarView.emoticonButton.selected) {
        CGFloat emoticonKeyboardViewHeight = _emoticonTopBarView.js_height + _emoticonTopBarView.currentKeyboardHeight;
        
        tempFrame.size = CGSizeMake(JSSCREEN_W, emoticonKeyboardViewHeight);
    }
    else {
        CGFloat emoticonKeyboardViewHeight = _emoticonTopBarView.js_height + _emoticonTopBarView.currentKeyboardHeight;
        
        tempFrame.size = CGSizeMake(JSSCREEN_W, emoticonKeyboardViewHeight);
    }

    self.frame = tempFrame;
    
    self.js_top = JSSCREEN_H - self.js_height;
    
    [self changeSuperView];
}

- (void)js_emoticonWithSection:(NSInteger)section
                           row:(NSInteger)row {
    if (!_emoticonSize) {
        NSString *string = @"/";
        
        _emoticonSize = [string js_heightForFont:[UIFont systemFontOfSize:17.0f]
                                           width:CGFLOAT_MAX];
    }
    
    JSEmoticonTextAttachment *textAttachment = [[JSEmoticonTextAttachment alloc] init];
    
    textAttachment.emoticonString = [self searchKeyForValue:[NSString stringWithFormat:@"%ld", row + section * 20 + 1]
                                              forDictionary:self.emoticonDictionary];
    
    if (row != 20 && row + section * 20 + 1 < 56) {
        textAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", row + section * 20 + 1]];
        
        textAttachment.bounds = CGRectMake(0.0f, -4.0f, _emoticonSize, _emoticonSize);
        
        [_emoticonTopBarView.emoticonTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]
                                                                         atIndex:_emoticonTopBarView.emoticonTextView.selectedRange.location];
        
        _emoticonTopBarView.emoticonTextView.selectedRange = NSMakeRange(_emoticonTopBarView.emoticonTextView.selectedRange.location + 1, _emoticonTopBarView.emoticonTextView.selectedRange.length);
        
        [self resetEmoticonTextView];
    }
    else if (row == 20) {
        [_emoticonTopBarView.emoticonTextView deleteBackward];
    }
}

- (void)js_sendClick {
    [self js_emoticonSendButtonClick];
}

- (void)js_emoticonSendButtonClick {
    __block NSString *plainString;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        plainString = [_emoticonTopBarView.emoticonTextView.attributedText setupPlainString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.emoticonKeyboardDelegate respondsToSelector:@selector(js_emoticonKeyboardSendPlainString:)]) {
                [self.emoticonKeyboardDelegate js_emoticonKeyboardSendPlainString:plainString];
            }
        });
    });
}

#pragma mark Notification
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark Action
- (void)changeEmoticonKeyboardView {
    [UIView animateWithDuration:0.3f animations:^{
        self.js_top = JSSCREEN_H - _emoticonTopBarView.currentKeyboardHeight - _emoticonTopBarView.js_height;
    }];
    
    [self changeSuperView];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    NSValue *endValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect endFrame = endValue.CGRectValue;
    
    _emoticonTopBarView.currentKeyboardHeight = endFrame.size.height;
    _emoticonTopBarView.emoticonButton.selected = NO;
    
    [self changeEmoticonKeyboardView];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _emoticonTopBarView.currentKeyboardHeight = _emoticonCollectionView.js_height + _emoticonPageView.js_height + _emoticonToolBarView.js_height;
    
    [self changeEmoticonKeyboardView];
}

- (void)resetEmoticonTextView {
    NSRange wholeRange = NSMakeRange(0, _emoticonTopBarView.emoticonTextView.textStorage.length);
    
    [_emoticonTopBarView.emoticonTextView.textStorage removeAttribute:NSFontAttributeName
                                                                range:wholeRange];
    [_emoticonTopBarView.emoticonTextView.textStorage addAttribute:NSFontAttributeName
                                                             value:[UIFont systemFontOfSize:17.0f]
                                                             range:wholeRange];
    
    [_emoticonTopBarView.emoticonTextView scrollRectToVisible:CGRectMake(0.0f, 0.0f, _emoticonTopBarView.emoticonTextView.contentSize.width, _emoticonTopBarView.emoticonTextView.contentSize.height)
                                                     animated:NO];
    //  重新设置输入框视图的 Frame
    [_emoticonTopBarView resetEmoticonTopBar];
}

- (NSString *)searchKeyForValue:(NSString *)value
                  forDictionary:(NSDictionary *)dictionary {
    __block NSString *searchKey;
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqualToString:value]) {
            searchKey = key;
            *stop = YES;
        }
    }];
    
    return searchKey;
}

- (void)changeSuperView {
    if ([self.emoticonKeyboardDelegate respondsToSelector:@selector(js_updateSuperView)]) {
        [self.emoticonKeyboardDelegate js_updateSuperView];
    }
}

#pragma mark Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
