//
//  NSString+Size.m
//  bitmedia
//
//  Created by meng qian on 14-3-4.
//  Copyright (c) 2014年 thinktube. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize) sizeWithWidth:(float)width andFont:(UIFont *)font {
    return [self sizeWithWidth:width andFont:font leftPadding:0];
}

- (int)convertToLength {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

- (CGSize) sizeWithWidth:(float)width andFont:(UIFont *)font leftPadding:(CGFloat)leftPadding {
    CGSize returnSize = CGSizeMake(width, 0);
    CGSize maxSize = CGSizeMake(width, 999);
    CGRect rect = CGRectZero;
    
    // iOS 7
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //        paragraphStyle.lineSpacing = H_5;
    rect = [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle}
                              context:nil];
    returnSize.height  = rect.size.height+leftPadding;
    returnSize.width  = rect.size.width;
    
    return returnSize;
}
- (CGSize) sizeWithWidth:(float)width andLabel:(UILabel *)label {
    CGSize returnSize = CGSizeMake(width, 0);
    CGSize maxSize = CGSizeMake(width, 999);
    CGRect rect = CGRectZero;
    // iOS 7
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = label.lineBreakMode;
    paragraphStyle.alignment = label.textAlignment;
    //        paragraphStyle.lineSpacing = H_5;
    rect = [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:label.font,NSParagraphStyleAttributeName: paragraphStyle}
                              context:nil];
    returnSize.height  = rect.size.height;
    returnSize.width  = rect.size.width;
    
    return returnSize;
}

- (CGSize) sizeWithWidth:(float)width andFont:(UIFont *)font andLineSpaceing:(CGFloat)height
{
    return [self sizeWithWidth:width andFont:font andLineSpaceing:height leftPadding:0];
}

- (CGSize) sizeWithWidth:(float)width andFont:(UIFont *)font andLineSpaceing:(CGFloat)height leftPadding:(CGFloat) leftPadding {
    CGSize returnSize = CGSizeMake(width, 0);
    CGSize maxSize = CGSizeMake(width, 999);
    CGRect rect = CGRectZero;
    
    // iOS 7
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = height;
    
    rect = [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle}
                              context:nil];
    returnSize.height  = rect.size.height+leftPadding;
    returnSize.width  = rect.size.width;
    
    return returnSize;
}

- (CGSize) sizeWithHeight:(float)height andFont:(UIFont *)font
{
#if 0
    CGSize returnSize = CGSizeMake(0, height);
#else
    CGSize returnSize;
#endif
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);

    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    returnSize = [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName: paragraphStyle}
                              context:nil].size;
    
    return returnSize;
}

@end
