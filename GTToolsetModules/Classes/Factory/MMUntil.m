//
//  MMUntil.m
//  Universitystudent
//
//  Created by XuMing on 13-12-8.
//  Copyright (c) 2013年 XuMing. All rights reserved.
//

#import "MMUntil.h"
#import <YYKit/YYKit.h>
#import <GTToolsetModules/ConfigurationHeader.h>
#import <QuartzCore/QuartzCore.h>


@implementation MMUntil

+ (void)showViewAnimate:(UIView*)view andSuccess:(void (^)(id responseObject))success
{
    [UIView animateWithDuration:0.1 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
            }completion:^(BOOL finished) {
                success(nil);
            }];
        }];
    }];
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font
{
    UILabel* lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.font = font;
    lbl.backgroundColor = [UIColor clearColor];

    return lbl;
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font withtext:(NSString*)str
{
    UILabel* lbl = [self createLabelWithFrame:frame font:font];
    lbl.text = str;

    return lbl;
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color
{
    UILabel* lbl = [self createLabelWithFrame:frame font:font];
    lbl.textColor = color;

    return lbl;
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color withtext:(NSString*)str

{
    UILabel* lbl = [self createLabelWithFrame:frame font:font];
    lbl.textColor = color;
    lbl.text = str;

    return lbl;
}

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame image:(NSString*)str
{
    UIImageView* imgv = [[UIImageView alloc] initWithFrame:frame];
    imgv.userInteractionEnabled = YES;
    imgv.image = [UIImage imageNamed:str];
    return imgv;
}

+ (UITextView*)createTextViewWithFrame:(CGRect)frame
{
    UITextView* imgv = [[UITextView alloc] initWithFrame:frame];
    imgv.userInteractionEnabled = YES;
    imgv.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    imgv.layer.borderColor = colorref;
    
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    return imgv;
}

+ (UITextView*)createTextViewWithFrame:(CGRect)frame withFont:(UIFont*)font
{
    UITextView* tx = [self createTextViewWithFrame:frame];
    tx.font = font;
    return tx;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
{

    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    UITextField* imgv = [[UITextField alloc] initWithFrame:frame];
    imgv.userInteractionEnabled = YES;
    //    imgv.layer.borderWidth=1;
    //    imgv.layer.borderColor=RGBACOLOR(216, 216, 216, 1.0).CGColor;
    imgv.leftView = view;
    imgv.leftViewMode = UITextFieldViewModeAlways;
    imgv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    imgv.backgroundColor = [UIColor whiteColor];
    return imgv;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withTag:(NSInteger)tag
{

    UITextField* tx = [self createTextFieldWithFrame:frame];
    tx.tag = tag;
    return tx;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withFont:(UIFont*)font
{
    UITextField* tx = [self createTextFieldWithFrame:frame];
    tx.font = font;
    return tx;
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    if (strh != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:strh] forState:UIControlStateHighlighted];
    }
    [btn setTitle:title forState:UIControlStateNormal];

    return btn;
}

+ (UIButton*)createImgButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    if (strh != nil) {
        [btn setImage:[UIImage imageNamed:strh] forState:UIControlStateHighlighted];
    }
    [btn setTitle:title forState:UIControlStateNormal];

    return btn;
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame backgroundColor:(UIColor *)backColor font:(UIFont*)font textColor:(UIColor*)color Title:(NSString*)title
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.backgroundColor = backColor;
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    return btn;
}

+ (UILabel*)theAdaptiveLable:(NSString*)str3 spacingCounts:(NSInteger)m spacingCounts:(NSInteger)lenh
{
    UILabel* lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:str3];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:m]; //调整行间距
    //设置字的颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:40.0 / 255.0 green:153.0 / 255.0 blue:1.0 / 255.0 alpha:1.0] range:NSMakeRange(0, lenh)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    lable.attributedText = str;
    [lable sizeToFit];
    lable.backgroundColor = [UIColor clearColor];
    return lable;
}
/**
 *   对UILable 显示不同颜色和行高的封装
 *
 *  @param counts     uilable的内容
 *  @param m          行高
 *  @param lineHeight 要显示颜色字体的个数
 *  @param color      要显示的颜色
 *
 *  @return 返回UILable
 */
+ (UILabel*)theAdaptiveLable:(NSString*)counts spacingCounts:(NSInteger)m spacingCounts:(NSInteger)lineHeight colorWords:(UIColor*)color
{
    UILabel* lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:counts];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:m];
    //设置字的颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, lineHeight)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    lable.attributedText = str;
    [lable sizeToFit];
    lable.backgroundColor = [UIColor clearColor];
    return lable;
}
/**
 * 自适应lable的高度
 *
 *  @param text    传过来的内容
 *  @param labFont 这个font 要和lable的font 是一致的；
 *  @param wide    这个宽度最好和你定义的lable的宽度一致
 *
 *  @return 高度
 */
+ (CGFloat)contentCellHeightWithText:(NSString*)text lableFont:(UIFont*)labFont
                             labWide:(NSInteger)wide
{
    NSInteger ch;
    UIFont* font = labFont; //11 一定要跟label的显示字体大小一致
    //设置字体
    CGSize size = CGSizeMake(wide, MAXFLOAT); //注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    if (CurrentSystemVersion>7.0) //IOS 7.0 以上
    {
        NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping]; //ios7以上已经摒弃的这个方法
        
    }
    ch = size.height + 20;
    return ch;
}



+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch WihtSlected:(BOOL)Senected
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frameBtn;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    [button.layer setBorderColor:colorref]; //边框颜色
    [button.layer setBorderColor:colorref]; //边框颜色
    CGSize imageSize = CGSizeMake(button.frame.size.width, button.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorTouch set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorbg set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:pressedColorImg1 forState:UIControlStateNormal];
    if (Senected) {
        [button setBackgroundImage:pressedColorImg forState:UIControlStateSelected];
        //[button setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
    }
    else {
        [button setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
    }
  
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    
    return button;
}

+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frameBtn;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    [button.layer setBorderColor:colorref]; //边框颜色
    [button.layer setBorderColor:colorref]; //边框颜色
    CGSize imageSize = CGSizeMake(button.frame.size.width, button.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorTouch set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    //    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    //    [colorbg set];
    //    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:pressedColorImg1 forState:UIControlStateNormal];

    //[button setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];

    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    return button;
}

+(UIImage *)CreateImageByColorbg:(UIColor*)colorbg withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [colorbg set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg1;

}

/**
 *  画一个button
 *
 *  @param butFrame   button 的大小
 *  @param colorbg    背景颜色
 *  @param colorTouch 按下去的颜色
 *  @param m          画圆，圆的半径
 *
 *  @return   button
 */
+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m
{
    UIButton* button = [self createbuttonWithFrame:butFrame buttonColorbg:colorbg buttonColorTouch:colorTouch];
    button.layer.cornerRadius = m;
    button.layer.masksToBounds = YES;

    return button;
}

+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m withSelect:(BOOL)y
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = butFrame;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    [button.layer setBorderColor:colorref]; //边框颜色
    [button.layer setBorderColor:colorref]; //边框颜色
    CGSize imageSize = CGSizeMake(button.frame.size.width, button.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorTouch set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorbg set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:pressedColorImg1 forState:UIControlStateNormal];
    
    [button setBackgroundImage:pressedColorImg forState:UIControlStateSelected];

    button.layer.cornerRadius = m;
    button.layer.masksToBounds = YES;
    
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);

    return button;
}


@end
