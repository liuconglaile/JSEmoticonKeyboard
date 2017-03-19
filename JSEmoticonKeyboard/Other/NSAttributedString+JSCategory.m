//
//  NSAttributedString+JSCategory.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "NSAttributedString+JSCategory.h"

#import "JSEmoticonTextAttachment.h"

@implementation NSAttributedString (JSCategory)
- (NSString *)setupPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName
                     inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(JSEmoticonTextAttachment *value, NSRange range, BOOL *stop) {
                      if (value) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:value.emoticonString];
                          
                          base += value.emoticonString.length - 1;
                      }
                  }];
    
    return plainString;
}

@end
