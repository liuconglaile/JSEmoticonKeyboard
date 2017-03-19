//
//  JSEmoticonCollectionViewFlowLayout.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 17/1/13.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSEmoticonCollectionViewFlowLayout.h"

static NSUInteger emoticonCellNumberOfRow = 7;
static NSUInteger emoticonCellRow = 3;

@interface JSEmoticonCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray *attributesArray;

@end

@implementation JSEmoticonCollectionViewFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(JSSCREEN_W / 7.0f, JSSCREEN_W / 7.0f);
    
    self.minimumLineSpacing = 0.0f;
    self.minimumInteritemSpacing = 0.0f;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
    if(attributes.representedElementKind != nil) {
        return;
    }

    NSUInteger section = attributes.indexPath.section;
    NSUInteger item = attributes.indexPath.item;
    
    NSUInteger page = item / (emoticonCellNumberOfRow * emoticonCellRow);
    
    NSUInteger x = self.itemSize.width * (item % emoticonCellNumberOfRow) + page * JSSCREEN_W + section * JSSCREEN_W;
    NSUInteger y = self.itemSize.height * ((item - page * emoticonCellRow * emoticonCellNumberOfRow) / emoticonCellNumberOfRow);
    
    attributes.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
    
    [_attributesArray addObject:attributes];

}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    
    [self applyLayoutAttributes:attribute];
    
    return attribute;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSArray *tempArray = [self deepCopyWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in tempArray) {
        [self applyLayoutAttributes:attribute];
    }
    
    return tempArray;
}

#pragma mark Deep Copy
- (NSArray *)deepCopyWithArray:(NSArray *)array {
    NSMutableArray *copysArray = [NSMutableArray arrayWithCapacity:array.count];
    
    for (UICollectionViewLayoutAttributes *attribute in array) {
        [copysArray addObject:[attribute copy]];
    }
    
    return copysArray;
}

@end
