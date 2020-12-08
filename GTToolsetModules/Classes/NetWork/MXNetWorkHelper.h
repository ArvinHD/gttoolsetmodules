//
//  MXNetWorkHelper.h
//  GTWorkBench
//
//  Created by yjh on 2020/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXNetWorkHelper : NSObject

/** 请求成功的Block */
typedef void(^PPHttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^PPHttpRequestFailed)(NSError *error);

/** 缓存的Block */
typedef void(^PPHttpRequestCache)(id responseCache);

/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
              serviceName:(NSString *)service
               parameters:(id)parameters
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure;

@end

NS_ASSUME_NONNULL_END
