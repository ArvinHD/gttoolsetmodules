//
//  GTViewController.m
//  GTToolsetModules
//
//  Created by xuchunyu-caibaoshuo on 08/31/2020.
//  Copyright (c) 2020 xuchunyu-caibaoshuo. All rights reserved.
//

#import "GTViewController.h"
#import <GTToolsetModules/PPNetworkHelper.h>
#import <GTToolsetModules/MXNetWorkHelper.h>
#import <YYKit/YYKit.h>
#import <GTToolsetModules/ConfigurationHeader.h>
#import "AFNetworking.h"
#import <GTToolsetModules/MBProgressHUD+XY.h>

@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showLoadingAnimationView:self.view];
    
//    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
//    [dic1 setValue:@"MTAuNDIuNC4w|ZjhlOTliZGQxMzQxMmFlZTJmNTdkNTExZGIxMzYzNWNiNmExZjYxOWNjY2E0OGUzZDcyYzVlMTY5NDg5ZjMyNg==|Fmb/La1Gk1Wdupf0Rdv5zUvGhDs=" forKey:@"third_return_params"];
//    [dic1 setValue:@"Bearer JD6-bbFhsEyK2lfmc23EmdkZy2tCCT-fr_4J7HGAyI8GFg9y" forKey:@"AUTHORIZATION"];
//    YYCache *usercache = [[YYCache alloc]initWithName:KUserCacheName];
//    [usercache setObject:dic1 forKey:KUserModelCache];
//
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:@"ding" forKey:@"keyWord"];
//    [dic setValue:@"1" forKey:@"pageNo"];
//    [dic setValue:@"10" forKey:@"rows"];
//
////    [dic setValue:@"su" forKey:@"search"];
//
//    [PPNetworkHelper POST:@"http://10.152.160.25:60001/http/appPortal/API_CODE_16008496513612750000" serviceName:nil parameters:dic success:^(id responseObject) {
//           if([responseObject[@"respCode"] integerValue] == 00000){
//               NSLog(@"%@",responseObject);
//               NSLog(@"1111");
////               if(success){
////                   TPEntryListModel* entryListModel = [[TPEntryListModel alloc] initWithDictionary:responseObject[@"results"] error:nil];
////                   success(entryListModel);
////               }
//           }
//       } failure:^(NSError *error) {
////           if(fail){
////               fail(error);
////           }
//       }];
//    NSDictionary *paramDic = @{@"only_in_my_workbench":@(1)};
////    NSString *utf = [@"http://10.152.160.54/api/v1/apps/full" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [MBProgressHUD showNetworkDisconnectMessage:@"网络开小差 请稍后再试" View:self.view];
//    [MXNetWorkHelper GET:@"http://10.152.160.54/api/v1/apps/full" serviceName:@"" parameters:paramDic success:^(id  _Nonnull responseObject) {
//
//        NSLog(@"敏行请求成功%@",responseObject);
//
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"error==%@",error);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
