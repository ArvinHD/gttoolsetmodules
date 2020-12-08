//
//  MBProgressHUD+XY.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

/**
 MBProgressHUD 的二次封装
 */
@interface MBProgressHUD (XY)

+ (void)showSuccessMessage:(NSString *)Message View:(UIView *)View;
+ (void)showLoadingMessage:(NSString *)Message View:(UIView *)View;
+ (void)showWarningMessage:(NSString *)Message View:(UIView *)View;
+ (void)showErrorMessage:(NSString *)Message View:(UIView *)View;
+ (void)showNetworkDisconnectMessage:(NSString *)Message View:(UIView *)View;

+ (void)showLoadingAnimationView:(UIView *)View;


+(void)hidden:(UIView *)View;

@end
