//
//  MBProgressHUD+XY.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "MBProgressHUD+XY.h"
#import "ConfigurationHeader.h"
#import <YYKit/YYKit.h>
#import <GTToolsetModules/GTLoadResource.h>
#import <GTResourceModules/GTImagesResource.h>
#import <Lottie/Lottie.h>

const NSInteger hideTime = 2.5;

@implementation MBProgressHUD (XY)

+ (void)showSuccessMessage:(NSString *)Message View:(UIView *)View{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image =  [[GTLoadResource getResourceOfImageWithName:@"toast_success" withClass:[GTImagesResource class] withBundleName:@"GTResourceModules"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.75f];
    hud.mode = MBProgressHUDModeCustomView;
    CGRect rect = [Message boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    hud.minSize = CGSizeMake(rect.size.width+64, 41);
    hud.bezelView.layer.cornerRadius = 20.5;
    
    UIImageView * customView1 = [[UIImageView alloc]initWithFrame:CGRectMake(17,11.5, 18, 18)];
    [customView1 setImage:image];
    [hud.bezelView addSubview:customView1];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView1.frame)+12, 0,KScreenWidth-95,41)];
    titleLabel.text = Message;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [hud.bezelView addSubview:titleLabel];
    
    CGFloat margin = KScreenHeight/2-205-41 ;
    [hud setOffset:CGPointMake(hud.offset.x, margin)];
    
    [hud hideAnimated:YES afterDelay:hideTime];
    
}

+ (void)showLoadingMessage:(NSString *)Message View:(UIView *)View{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image =  [[GTLoadResource getResourceOfImageWithName:@"toast_loading" withClass:[GTImagesResource class] withBundleName:@"GTResourceModules"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.75f];
    hud.mode = MBProgressHUDModeCustomView;
    CGRect rect = [Message boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    hud.minSize = CGSizeMake(rect.size.width+64, 41);
    hud.bezelView.layer.cornerRadius = 20.5;
    
    UIImageView * customView1 = [[UIImageView alloc]initWithFrame:CGRectMake(17,11.5, 18, 18)];
    [customView1 setImage:image];
    [hud.bezelView addSubview:customView1];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView1.frame)+12, 0,KScreenWidth-95,41)];
    titleLabel.text = Message;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [hud.bezelView addSubview:titleLabel];
    CGFloat margin = KScreenHeight/2-205-41 ;
    [hud setOffset:CGPointMake(hud.offset.x, margin)];
    
}

+ (void)showWarningMessage:(NSString *)Message View:(UIView *)View{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image =  [[GTLoadResource getResourceOfImageWithName:@"toast_warning" withClass:[GTImagesResource class] withBundleName:@"GTResourceModules"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.75f];
    hud.mode = MBProgressHUDModeCustomView;
    CGRect rect = [Message boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    hud.minSize = CGSizeMake(rect.size.width+64, 41);
    hud.bezelView.layer.cornerRadius = 20.5;
    
    UIImageView * customView1 = [[UIImageView alloc]initWithFrame:CGRectMake(17,11.5, 18, 18)];
    [customView1 setImage:image];
    [hud.bezelView addSubview:customView1];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView1.frame)+12, 0,KScreenWidth-95,41)];
    titleLabel.text = Message;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [hud.bezelView addSubview:titleLabel];
    CGFloat margin = KScreenHeight/2-205-41 ;
    [hud setOffset:CGPointMake(hud.offset.x, margin)];
    
    [hud hideAnimated:YES afterDelay:hideTime];
}

+ (void)showErrorMessage:(NSString *)Message View:(UIView *)View{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image =  [[GTLoadResource getResourceOfImageWithName:@"toast_error" withClass:[GTImagesResource class] withBundleName:@"GTResourceModules"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.75f];
    hud.mode = MBProgressHUDModeCustomView;
    CGRect rect = [Message boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
    hud.minSize = CGSizeMake(rect.size.width+64, 41);
    hud.bezelView.layer.cornerRadius = 20.5;
    
    UIImageView * customView1 = [[UIImageView alloc]initWithFrame:CGRectMake(17,11.5, 18, 18)];
    [customView1 setImage:image];
    [hud.bezelView addSubview:customView1];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView1.frame)+12, 0,KScreenWidth-95,41)];
    titleLabel.text = Message;
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    [hud.bezelView addSubview:titleLabel];
    
    CGFloat margin = KScreenHeight/2-205-41 ;
    [hud setOffset:CGPointMake(hud.offset.x, margin)];
    
    [hud hideAnimated:YES afterDelay:hideTime];
}

+ (void)showNetworkDisconnectMessage:(NSString *)Message View:(UIView *)View{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];

       hud.mode = MBProgressHUDModeCustomView;
       UIImage *image =  [[GTLoadResource getResourceOfImageWithName:@"toast_network_fail" withClass:[GTImagesResource class] withBundleName:@"GTResourceModules"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

       hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.75f];
       hud.mode = MBProgressHUDModeCustomView;
       CGRect rect = [Message boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
       hud.minSize = CGSizeMake(rect.size.width+64, 41);
       hud.bezelView.layer.cornerRadius = 20.5;

       UIImageView * customView1 = [[UIImageView alloc]initWithFrame:CGRectMake(17,11.5, 18, 18)];
       [customView1 setImage:image];
       [hud.bezelView addSubview:customView1];

       UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customView1.frame)+12, 0,KScreenWidth-95,41)];
       titleLabel.text = Message;
       titleLabel.textAlignment = NSTextAlignmentLeft;
       titleLabel.font = [UIFont systemFontOfSize:15];
       titleLabel.textColor = [UIColor whiteColor];
       [hud.bezelView addSubview:titleLabel];

       CGFloat margin = KScreenHeight/2-205-41 ;
       [hud setOffset:CGPointMake(hud.offset.x, margin)];

       [hud hideAnimated:YES afterDelay:hideTime];
}

+ (void)showLoadingAnimationView:(UIView *)View{

    NSBundle *currentBundle = [NSBundle bundleForClass:[GTLoadResource class]];
    NSString *path = [currentBundle pathForResource:@"loading_animation" ofType:@"json" inDirectory:@"GTToolsetModules.bundle"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    LOTAnimationView *animationView= [LOTAnimationView animationFromJSON:dic];
    animationView.loopAnimation = YES;
    animationView.frame = CGRectMake(0, 0, 88, 88);

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:View animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    [hud.bezelView addSubview:animationView];
    hud.minSize = CGSizeMake(88, 88);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.f];
    [animationView play];
    [hud showAnimated:YES];
}

+(void)hidden:(UIView *)View{
    [MBProgressHUD hideHUDForView:View animated:YES];
}

@end
