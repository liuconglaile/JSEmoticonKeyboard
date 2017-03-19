//
//  JSEmoticonPageView.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/14.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonPageView.h"

@implementation JSEmoticonPageView
#pragma mark Instancetype
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
        
        [self addSubview:self.emoticonPageControl];
    }
    
    return self;
}

#pragma mark Lazy
-(UIPageControl *)emoticonPageControl {
    if (!_emoticonPageControl) {
        _emoticonPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((JSSCREEN_W - 200.0f) / 2.0f,
                                                                               0.0f,
                                                                               200.0f,
                                                                               20.0f)];
        
        _emoticonPageControl.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
        
        _emoticonPageControl.numberOfPages = 3.0f;
        
        _emoticonPageControl.pageIndicatorTintColor = [UIColor js_colorWithHexString:@"#D8D8D8"];
        
        _emoticonPageControl.currentPageIndicatorTintColor = [UIColor js_colorWithHexString:@"#8B8A8D"];
    }
    
    return _emoticonPageControl;
}

@end
