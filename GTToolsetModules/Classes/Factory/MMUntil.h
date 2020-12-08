//
//  MMUntil.h
//  Universitystudent
//
//  Created by XuMing on 13-12-8.
//  Copyright (c) 2013年 XuMing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MMUntil : NSObject
+ (void)showMessage:(NSString *)msg Type:(int)type;
+ (void)showViewAnimate:(UIView*)view andSuccess:(void (^)(id responseObject))success;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font withtext:(NSString*)str;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color withtext:(NSString*)str;
+ (UIImageView*)createImageViewWithFrame:(CGRect)frame image:(NSString*)str;
+ (UITextView*)createTextViewWithFrame:(CGRect)frame;
+ (UITextView*)createTextViewWithFrame:(CGRect)frame withFont:(UIFont*)font;
+ (UIButton*)createButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title;
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withFont:(UIFont*)font;
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame;
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withTag:(NSInteger)tag;
//button
+ (UIButton*)createButtonWithFrame:(CGRect)frame backgroundColor:(UIColor *)backColor font:(UIFont*)font textColor:(UIColor*)color Title:(NSString*)title;

//+(UITextField *)CreateTxtFieldEx:(CGRect)rect withTag:(NSInteger)tag;
+ (UIButton*)createImgButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title;
+ (UILabel*)theAdaptiveLable:(NSString*)counts spacingCounts:(NSInteger)m spacingCounts:(NSInteger)lineHeight colorWords:(UIColor*)color;
+ (CGFloat)contentCellHeightWithText:(NSString*)text lableFont:(UIFont*)labFont
                             labWide:(NSInteger)wide;
+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch;
+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m;
+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch WihtSlected:(BOOL)Senected;

+ (NSString*)timerCountDown:(NSObject*)matchTimeObj;
+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m withSelect:(BOOL)y;
+(UIImage *)CreateImageByColorbg:(UIColor*)colorbg withSize:(CGSize)size;

@end
