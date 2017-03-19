//
//  JSEmoticonCollectionViewCell.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/14.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonCollectionViewCell.h"

@interface JSEmoticonCollectionViewCell ()

@property (nonatomic, strong) UIImageView *emoticonImageView;

@end

@implementation JSEmoticonCollectionViewCell
#pragma mark Action
- (void)createEmoticonCollectionViewCellWithIndexPath:(NSIndexPath *)indexPath {
    self.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
    
    if (indexPath.row == 20.0f) {
        self.emoticonImageView.image = [UIImage imageNamed:@"DeleteEmoticonBtn"];
    }
    else {
        self.emoticonImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", indexPath.row + indexPath.section * 20 + 1]];
    }
    
    [self addSubview:_emoticonImageView];
}

#pragma mark Lazy
- (UIImageView *)emoticonImageView {
    if (!_emoticonImageView) {
        _emoticonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f,
                                                                           10.0f,
                                                                           self.frame.size.width - 20.0f,
                                                                           self.frame.size.height - 20.0f)];
        
        _emoticonImageView.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
    }
    
    return _emoticonImageView;
}

@end
