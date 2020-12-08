//
//  MXNetWorkHelper.m
//  GTWorkBench
//
//  Created by yjh on 2020/10/10.
//

#import "MXNetWorkHelper.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AESCipher.h"
#import "HeaderModel.h"
#import "MBProgressHUD+XY.h"
#import "ConfigurationHeader.h"
#import "PPNetworkCache.h"
#import <GTToolsetModules/FCUUID.h>
#import <YYKit/YYKit.h>
#import <AFNetworking/AFNetworking.h>

#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif

@implementation MXNetWorkHelper
static BOOL _isOpenLog;   // 是否已开启日志打印
static BOOL _isOpenAES;   // 是否已开启加密传输
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_mxSessionManager;
#pragma mark - - 获取Token - -
+ (NSString *)getRequestToken {
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults]objectForKey:KUserCacheName];
    return userDic[@"Authorization"];
}

+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                       serviceName:(NSString *)service
                        parameters:(id)parameters
                           success:(PPHttpRequestSuccess)success
                           failure:(PPHttpRequestFailed)failure {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parameter setValue:@"mobile" forKey:@"platform"];
    
    return [self GET:URL serviceName:service parameters:parameter responseCache:nil success:success failure:failure];
}
#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
              serviceName:(NSString *)service
               parameters:(id)parameters
            responseCache:(PPHttpRequestCache)responseCache
                  success:(PPHttpRequestSuccess)success
                  failure:(PPHttpRequestFailed)failure {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //读取缓存
    responseCache!=nil ? responseCache([PPNetworkCache httpCacheForURL:URL parameters:parameter]) : nil;
    // 重新设置ContentTypes
    _mxSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    // 设置 header
    [self setHeaderWithServiceName:service];
    NSURLSessionTask *sessionTask = [_mxSessionManager GET:URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenAES) {
            //解密
            responseObject = aesDecryptWithData(responseObject);
        }
        if (_isOpenLog) {PPLog(@"responseObject = %@",[self jsonToString:responseObject]);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [PPNetworkCache setHttpCache:responseObject URL:URL parameters:parameter] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {PPLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
       
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}
#pragma mark - set header
+ (void)setHeaderWithServiceName:(NSString *)service {
    if([MXNetWorkHelper getRequestToken] && [MXNetWorkHelper getRequestToken].length > 0){
        // json形式提交数据
        //配置token
        NSString *token = [MXNetWorkHelper getRequestToken];
        [_mxSessionManager.requestSerializer setValue:token forHTTPHeaderField:@"AUTHORIZATION"];
    }else{
        // 未登录状态下清除token
        [_mxSessionManager.requestSerializer setValue:nil forHTTPHeaderField:@"AUTHORIZATION"];
    }
    HeaderModel *hModel = [HeaderModel new];
    [_mxSessionManager.requestSerializer setValue:hModel.imei forHTTPHeaderField:@"X-ATT-DeviceId"];
    [_mxSessionManager.requestSerializer setValue:[FCUUID uuidForDevice] forHTTPHeaderField:@"X-Request-ID"];

}

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - ——————— 加密 header 和 Body ————————
+(void)encodeParameters:(id)param{
    //加密 Header
//    [self encodeHeader];
    
    //参数不为空 且 已经开启加密
    if (ValidDict(param) && _isOpenAES) {
        [_mxSessionManager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
            NSString *contentStr = [parameters jsonStringEncoded];
            NSString *AESStr = aesEncrypt(contentStr);
            return AESStr;
        }];
    }
}


+ (void)initialize {
    _mxSessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _mxSessionManager.requestSerializer.timeoutInterval = 30.f;
    
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
//    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    _mxSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _mxSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _mxSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", @"multipart/form-data", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
   
    //开始log模式
//    [self openLog];
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}
@end
