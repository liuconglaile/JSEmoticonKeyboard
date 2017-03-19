//
//  JSEmoticonCollectionView.h
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/13.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSEmoticonCollectionDelegate <NSObject>
//  代理：返回 emoticonCollectionView 中对应的 section 和 row
- (void)js_emoticonWithSection:(NSInteger)section
                           row:(NSInteger)row;

@end

@interface JSEmoticonCollectionView : UICollectionView

@property (nonatomic, weak) id <JSEmoticonCollectionDelegate> emoticonDelegate;

@end
