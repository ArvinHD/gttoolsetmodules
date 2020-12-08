//
//  CommonMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/31.
//  Copyright © 2017年 徐阳. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//跳转-问题反馈
#define KNotificationPersonProblemFeedback @"PersonProblemFeedback"


//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"

//用户本地小应用缓存
#define KUserApppsCache @"KUserApppsCache"
//用户本地小应用缓存
#define KUserApppCache @"KUserApppCache"


//获取全部岗位缓存
#define KUserAllJobsCache @"KUserAllJobsCache"
//获取岗位信息缓存
#define KUserAllJobCache @"KUserAllJobCache"
//岗位切换通知
#define KUserJobChange @"KUserJobChange"



#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"

#pragma mark - ****************
//缓存字体
#define KFontCache @"KFontCache"

#endif /* CommonMacros_h */
