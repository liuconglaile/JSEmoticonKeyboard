//
//  JSDecoder.m
//  JSEmoticonKeyboardDemo
//
//  Created by 菅思博 on 2017/3/19.
//  Copyright © 2017年 菅思博. All rights reserved.
//

#import "JSDecoder.h"

#import "JSEmoticonTextAttachment.h"

static CGSize _emoticonSize;
static UIFont *_font;
static UIColor *_textColor;
static NSArray *_matches;
static NSString *_plainString;
static NSDictionary *_emoticonDictionary;
static NSMutableArray *_imageDataArray;
static NSMutableAttributedString *_attributedString;
static NSMutableAttributedString *_resultAttributedString;

static NSString *const _regexString = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";

@implementation JSDecoder
#pragma mark 公开方法
+ (NSMutableAttributedString *)js_decodeWithPlainString:(NSString *)plainString
                                                   font:(UIFont *)font {
    if (!plainString) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    else {
        _font = font;
        _plainString = plainString;
        _textColor = [UIColor blackColor];
        
        [self setupProperty];
        [self executeMatch];
        [self setupImageDataArray];
        [self setupResultStringUseReplace];
        
        return _resultAttributedString;
    }
}

#pragma mark 私有方法
+ (void)setupProperty {
    NSString *pathURL = [[NSBundle mainBundle] pathForResource:@"Emoticon"
                                                        ofType:@"plist"];
    
    _emoticonDictionary = [NSDictionary dictionaryWithContentsOfFile:pathURL];
    
    //  设置文本参数
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:4.0f];
    
    NSDictionary *attributeDictionary = @{
                                          NSFontAttributeName : _font,
                                          NSParagraphStyleAttributeName : paragraphStyle
                                          };
    
    CGSize maxsize = CGSizeMake(1000, MAXFLOAT);
    
    _emoticonSize = [@"/" boundingRectWithSize:maxsize
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributeDictionary
                                       context:nil].size;
    
    _attributedString = [[NSMutableAttributedString alloc] initWithString:_plainString
                                                               attributes:attributeDictionary];
}

+ (void)executeMatch {
    //  比对结果
    NSString *regexString = _regexString;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    NSRange totalRange = NSMakeRange(0, [_plainString length]);
    
    _matches = [regex matchesInString:_plainString
                              options:0
                                range:totalRange];
}

+ (void)setupImageDataArray {
    NSMutableArray *imageDataArray = [NSMutableArray array];
    
    //  遍历结果
    for (int i = (int)_matches.count - 1; i >= 0; i --) {
        NSMutableDictionary *recordDictionary = [NSMutableDictionary dictionary];
        
        JSEmoticonTextAttachment *attachment = [[JSEmoticonTextAttachment alloc] init];
        
        attachment.bounds = CGRectMake(0.0f, - 4.0f, _emoticonSize.height, _emoticonSize.height);
        
        NSTextCheckingResult *match = [_matches objectAtIndex:i];
        
        NSRange matchRange = [match range];
        
        NSString *keyString = [_plainString substringWithRange:matchRange];
        
        NSString *imageName = [_emoticonDictionary objectForKey:keyString];
        
        if (imageName == nil || imageName.length == 0) {
            continue;
        }
        
        [recordDictionary setObject:[NSValue valueWithRange:matchRange]
                             forKey:@"range"];
        [recordDictionary setObject:imageName
                             forKey:@"imageName"];
        
        [imageDataArray addObject:recordDictionary];
    }
    
    _imageDataArray = imageDataArray;
}

+ (void)setupResultStringUseReplace {
    NSMutableAttributedString *resultAttributedString = _attributedString;
    
    for (int i = 0; i < _imageDataArray.count ; i++) {
        NSRange range = [_imageDataArray[i][@"range"] rangeValue];
        
        NSDictionary *imageDictionary = [_imageDataArray objectAtIndex:i];
        
        NSString *imageName = [imageDictionary objectForKey:@"imageName"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                         ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        YYImage *image = [YYImage imageWithData:data
                                          scale:2.0f];
        
        image.preloadAllAnimatedImageFrames = YES;
        
        YYAnimatedImageView *animatedImageView = [[YYAnimatedImageView alloc] initWithImage:image];
        
        NSMutableAttributedString *attributedString = [NSMutableAttributedString yy_attachmentStringWithContent:animatedImageView
                                                                                                    contentMode:UIViewContentModeCenter
                                                                                                 attachmentSize:animatedImageView.frame.size
                                                                                                    alignToFont:_font
                                                                                                      alignment:YYTextVerticalAlignmentCenter];
        
        [resultAttributedString replaceCharactersInRange:range
                                    withAttributedString:attributedString];
    }
    
    _resultAttributedString = resultAttributedString;
}

@end
