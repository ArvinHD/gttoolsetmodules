//
//  GTLoadRequestURLObject.h
//  GTToolsetModules
//
//  Created by apple on 2020/9/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTLoadRequestURLObject : NSObject
/*!
 * 获取RequestURL的实例对象，用于加载URL的数值
 *
 * @return CDDLoadRequestURLOjbect对象
 */
+ (GTLoadRequestURLObject *)shareRequestURLObject;
    

/*!
 * 获取发起请求所用的URL实例对象
 *
 * @return URL根路径的值
 */
- (NSString *)getRequestURL:(NSString *)rootName;
    
@end

NS_ASSUME_NONNULL_END
