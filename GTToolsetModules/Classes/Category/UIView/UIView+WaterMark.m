//
//  UIView+WaterMark.m
//  Localization
//
//  Created by 明孔 on 2019/10/15.
//  Copyright © 2019 明孔. All rights reserved.
//

#import "UIView+WaterMark.h"

@implementation UIView (WaterMark)

-(void)addWaterMarkText:(NSString*)waterText WithTextColor:(UIColor*)color WithFont:(UIFont*)font{
    //计算水印文字的宽高
     NSString *waterMark = waterText;
    CGSize textSize = [waterMark sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat height =  [UIScreen mainScreen].bounds.size.height;
    CGFloat width =  [UIScreen mainScreen].bounds.size.width;
    NSInteger line = height*3.5/80; //多少行
    NSInteger row = 20;
   
    for (int i = 0; i < line; i ++) {
        for (int j = 0; j < row; j ++) {
            CATextLayer *textLayer = [[CATextLayer alloc]init];
            textLayer.contentsScale = [UIScreen mainScreen].scale;//按当前屏幕分辨显示，否则会模糊
            CFStringRef fontName = (__bridge CFStringRef)font.fontName;
            CGFontRef fontRef =CGFontCreateWithFontName(fontName);
            textLayer.font = fontRef;
            textLayer.fontSize = font.pointSize;
            textLayer.foregroundColor = color.CGColor;
            textLayer.alignmentMode = kCAAlignmentCenter;
            textLayer.string = waterMark;
            float y ;
            if (j%2 == 0) {
                y = i*60;
            }else{
                y = i*60+20;
            }
            textLayer.frame = CGRectMake(j*(textSize.width+5+50),  y, textSize.width+5, textSize.height);
            //旋转文字
            textLayer.transform = CATransform3DMakeRotation(-M_PI/15, 0,0,3);
            [self.layer insertSublayer:textLayer atIndex:0];
            
        }
    }
}

@end
