//
//  GTLoadRequestURLObject.m
//  GTToolsetModules
//
//  Created by apple on 2020/9/8.
//

#import "GTLoadRequestURLObject.h"

/*!
 * 定义实例对象用于初始化和使用
 */
static GTLoadRequestURLObject *_loadRequestURLObject = nil;

@interface GTLoadRequestURLObject ()
@property (nonatomic, readwrite, strong) NSDictionary *plistDict;//保留plist加载的数值
@end

@implementation GTLoadRequestURLObject
/*!
 * 获取RequestURL的实例对象，用于加载URL的数值
 *
 * @return CDDLoadRequestURLOjbect对象
 */
+ (GTLoadRequestURLObject *)shareRequestURLObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _loadRequestURLObject = [[GTLoadRequestURLObject alloc] init];
    });
    return _loadRequestURLObject;
}

/*!
 * 初始化当前实例对象，获取plist的内容
 */
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
    
/*!
 * 获取发起请求所用的URL实例对象
 *
 * @return URL根路径的值
 */
- (NSString *)getRequestURL:(NSString *)rootName
{
    if (self.plistDict) {
        NSDictionary *urlDict = self.plistDict[self.plistDict[rootName]];
        return urlDict[urlDict[@"ServiceEnvironment"]];
    }
    return nil;
}
    
#pragma mark - - Setter and Getter - -
/*!
 * 获取plist文件的内容 - Getter
 */
- (NSDictionary *)plistDict
{
    if (!_plistDict) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GTRequestURLConfiguration" ofType:@"plist"];
        _plistDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return _plistDict;
}

@end
