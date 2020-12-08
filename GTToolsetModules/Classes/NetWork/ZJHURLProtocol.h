//
//  ZJHURLProtocol.h
//  ZJHURLProtocol
//
//  Created by ZhangJingHao2345 on 2018/8/24.
//  Copyright © 2018年 ZhangJingHao2345. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 请求成功的Block */
typedef void(^RequestSuccess)(void);

@interface ZJHURLProtocol : NSURLProtocol

/// 开始监听
+ (void)startMonitor;

/// 停止监听
+ (void)stopMonitor;

///上传缓存信息
+ (void)upLoadMonitor:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName  success:(RequestSuccess)success;
@end
