//
//  ZJHURLProtocol.m
//  ZJHURLProtocol
//
//  Created by ZhangJingHao2345 on 2018/8/24.
//  Copyright © 2018年 ZhangJingHao2345. All rights reserved.
//

#import "ZJHURLProtocol.h"
#import "ZJHSessionConfiguration.h"
#import <YYKit/YYKit.h>
#import <AFNetworking/AFNetworking.h>
#import <GTToolsetModules/GTLoadRequestURLObject.h>
#import "MBProgressHUD+XY.h"
#import "UtilsInline.h"
#import <GTToolsetModules/FCUUID.h>

// 为了避免canInitWithRequest和canonicalRequestForRequest的死循环
static NSString *const kProtocolHandledKey = @"kProtocolHandledKey";

@interface ZJHURLProtocol () <NSURLConnectionDelegate,NSURLConnectionDataDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSOperationQueue     *sessionDelegateQueue;
@property (nonatomic, strong) NSURLResponse        *response;

@end

@implementation ZJHURLProtocol

#pragma mark - Public

/// 开始监听
+ (void)startMonitor {
    ZJHSessionConfiguration *sessionConfiguration = [ZJHSessionConfiguration defaultConfiguration];
    [NSURLProtocol registerClass:[ZJHURLProtocol class]];
    if (![sessionConfiguration isSwizzle]) {
        [sessionConfiguration load];
    }
}

/// 停止监听
+ (void)stopMonitor {
    ZJHSessionConfiguration *sessionConfiguration = [ZJHSessionConfiguration defaultConfiguration];
    [NSURLProtocol unregisterClass:[ZJHURLProtocol class]];
    if ([sessionConfiguration isSwizzle]) {
        [sessionConfiguration unload];
    }
}

#pragma mark - Override

/**
 需要控制的请求
 
 @param request 此次请求
 @return 是否需要监控
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    // 如果是已经拦截过的就放行，避免出现死循环
    if ([NSURLProtocol propertyForKey:kProtocolHandledKey inRequest:request] ) {
        return NO;
    }
    
    // 不是网络请求，不处理
    if (![request.URL.scheme isEqualToString:@"http"] &&
        ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    
    // 指定拦截网络请求，如：www.baidu.com
    //    if ([request.URL.absoluteString containsString:@"www.baidu.com"]) {
    //        return YES;
    //    } else {
    //        return NO;
    //    }
    
    // 拦截所有
    return YES;
}

/**
 设置我们自己的自定义请求
 可以在这里统一加上头之类的
 
 @param request 应用的此次请求
 @return 我们自定义的请求
 */
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    // 设置已处理标志
    [NSURLProtocol setProperty:@(YES)
                        forKey:kProtocolHandledKey
                     inRequest:mutableReqeust];
    return [mutableReqeust copy];
}

// 重新父类的开始加载方法
- (void)startLoading {
    NSLog(@"***ZJH 监听接口：%@", self.request.URL.absoluteString);
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.sessionDelegateQueue = [[NSOperationQueue alloc] init];
    self.sessionDelegateQueue.maxConcurrentOperationCount = 1;
    self.sessionDelegateQueue.name = @"com.hujiang.wedjat.session.queue";
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:configuration
                                  delegate:self
                             delegateQueue:self.sessionDelegateQueue];

    NSMutableURLRequest *request = [self.request mutableCopy];
     NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"gt_third_return_params"];
    if (accessToken) {
        NSCharacterSet *customSet = [NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "];
        accessToken = [accessToken stringByAddingPercentEncodingWithAllowedCharacters:customSet.invertedSet];
        [request setValue:accessToken forHTTPHeaderField:@"_idp_session"];
        self.dataTask = [session dataTaskWithRequest:request];
    }else{
        self.dataTask = [session dataTaskWithRequest:self.request];
    }
    [self.dataTask resume];
}

// 结束加载
- (void)stopLoading {
    [self.dataTask cancel];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
   
    if (!error) {
        [self.client URLProtocolDidFinishLoading:self];

    } else if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled){
    
    } else {
        [self.client URLProtocol:self didFailWithError:error];
        NSInteger errorNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"ErrorNumberID"];
        errorNumber +=1;
        if (errorNumber == 3) {
            errorNumber = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
              [MBProgressHUD showNetworkDisconnectMessage:@"当前网络环境不稳定，请检查网络" View:GetCurrentViewCon().view];
            });
            
        }
        [[NSUserDefaults standardUserDefaults] setInteger:errorNumber forKey:@"ErrorNumberID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.dataTask = nil;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics{
    NSURLSessionTaskTransactionMetrics *me = metrics.transactionMetrics.firstObject;

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //缓存
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    [dataDic setValue:@"net" forKey:@"logType"];
    long startime = (long long)[me.requestStartDate timeIntervalSince1970]*1000;
     long endtime = (long long)[me.requestEndDate timeIntervalSince1970]*1000;
     [dataDic setValue:[NSNumber numberWithLong:startime] forKey:@"netStartTime"];
     [dataDic setValue:[NSNumber numberWithLong:endtime] forKey:@"netEndTime"];
    [dataDic setValue:task.originalRequest.URL forKey:@"URL"];
    
    NSDictionary*userDic= [[NSUserDefaults standardUserDefaults]objectForKey:@"KUserModelCache"];
     if (userDic) {
         [dataDic setValue:userDic[@"login_name"] forKey:@"userId"];
     }
    [dataDic setValue:[FCUUID uuidForDevice] forKey:@"deviceId"];

    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    [dataDic setValue:[NSNumber numberWithInteger:statusCode] forKey:@"code"];
    
    if (statusCode >= 400) {
        [dataDic setValue:[NSNumber numberWithBool:NO] forKey:@"isSuccess"];
    }else{
        [dataDic setValue:[NSNumber numberWithBool:YES] forKey:@"isSuccess"];
    }
    
    NSMutableDictionary *deviceDic = [NSMutableDictionary dictionary];
    [deviceDic setValue:@"device" forKey:@"logType"];
    [deviceDic setValue:@"iOS" forKey:@"deviceType"];
    [deviceDic setValue:[[UIDevice currentDevice] systemVersion] forKey:@"osVersion"];
    [deviceDic setValue:[FCUUID uuidForDevice]  forKey:@"deviceId"];
    [deviceDic setValue:[self timeString] forKey:@"active_time"];
    
    [dic setObject:dataDic forKey:@"net"];
    [dic setObject:deviceDic forKey:@"device"];
    //写入文件
    NSMutableString *dataString = [NSMutableString string];
    NSString *path = [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"information.json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
        NSString *temString =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [dataString appendString:temString];
    }
    NSString *str = [dataDic modelToJSONString];
    [dataString appendFormat:@"%@\r\n",str];
    [dataString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];

}

#pragma mark - NSURLSessionDataDelegate

// 当服务端返回信息时，这个回调函数会被ULS调用，在这里实现http返回信息的截
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    // 返回给URL Loading System接收到的数据，这个很重要，不然光截取不返回，就瞎了。
    [self.client URLProtocol:self didLoadData:data];
    
    // 打印返回数据
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr) {
        NSLog(@"***ZJH 截取数据 : %@", dataStr);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    completionHandler(NSURLSessionResponseAllow);
    self.response = response;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    if (response != nil){
        self.response = response;
        [[self client] URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
}

- (NSString *)timeString{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    NSInteger time = interval;
    NSString *timestamp = [NSString stringWithFormat:@"%zd",time];
    return timestamp;
}

+ (void)upLoadMonitor:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName  success:(RequestSuccess)success{
    NSString *baseUrl =  [[GTLoadRequestURLObject shareRequestURLObject]getRequestURL:@"APP"];
    NSString *url = [NSString stringWithFormat:@"%@API_CODE_16023037770652640000",baseUrl];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    sessionManager.requestSerializer.timeoutInterval = 30.f;
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", @"multipart/form-data", nil];
    [sessionManager.requestSerializer setValue:[FCUUID uuidForDevice] forHTTPHeaderField:@"X-ATT-DeviceId"];
    [sessionManager.requestSerializer setValue:[FCUUID uuidForDevice] forHTTPHeaderField:@"X-Request-ID"];
    [sessionManager.requestSerializer setValue:@"fileupload" forHTTPHeaderField:@"format"];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults]objectForKey:@"KUserCacheName"];
    NSString *token = userDic[@"third_return_params"];
    NSCharacterSet *customSet = [NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "];
    token = [token stringByAddingPercentEncodingWithAllowedCharacters:customSet.invertedSet];
    [sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"_idp_session"];
    
    [sessionManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"text/json"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-----------%@", responseObject);
         success ? success() : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}

@end
