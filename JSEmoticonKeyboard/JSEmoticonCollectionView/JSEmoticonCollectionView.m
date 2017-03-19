//
//  JSEmoticonCollectionView.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/13.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonCollectionView.h"

#import "JSEmoticonCollectionViewCell.h"
#import "JSEmoticonPageView.h"

static NSString *reuseIdentifier = @"JSEmoticonCollectionViewCell";

@interface JSEmoticonCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) JSEmoticonPageView *emoticonPageView;

@end

@implementation JSEmoticonCollectionView
#pragma mark Instancetype
- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];
    
    if (self) {
        self.backgroundColor = [UIColor js_colorWithHexString:@"#F7F7F9"];
        
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[JSEmoticonCollectionViewCell class]
 forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return self;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 21.0f;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSEmoticonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                   forIndexPath:indexPath];
 
    [cell createEmoticonCollectionViewCellWithIndexPath:indexPath];;
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3.0f;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.emoticonDelegate respondsToSelector:@selector(js_emoticonWithSection:row:)]) {
        [self.emoticonDelegate js_emoticonWithSection:indexPath.section
                                                  row:indexPath.row];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_emoticonPageView) {
        [self.superview.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[JSEmoticonPageView class]]) {
                _emoticonPageView = (JSEmoticonPageView *)obj;
                *stop = YES;
            }
        }];
    }

    float currentPage = scrollView.contentOffset.x / JSSCREEN_W;
    
    if (currentPage == 0.0 || currentPage == 1.0 || currentPage == 2.0) {
        _emoticonPageView.emoticonPageControl.currentPage = currentPage;
    }
}

@end
