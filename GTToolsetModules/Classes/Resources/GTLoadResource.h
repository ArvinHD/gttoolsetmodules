//
//  GTLoadResource.h
//  GTToolsetModules
//
//  Created by apple on 2020/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTLoadResource : NSObject


/*!
 * 获取xib资源文件
 *
 * @param nibClass 相应Bundle所存在的framework中，指定一个xib class类
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (UINib *)getResourceOfNibClass:(Class)nibClass withBundleName:(NSString *)bundleName;

/*!
 * 获取Plist资源数据
 *
 * @param plistName plist文件的名称 xx.plist
 * @param bundleClass 相应Bundle所存在的framework中，指定一个class类（例如CDDRouter）
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (NSDictionary *)getPlistInfoWithName:(NSString *)plistName withClass:(Class)bundleClass withBundleName:(NSString *)bundleName;

/*!
 * 获取图片资源文件
 *
 * @param imageName 图片的名称 xx.png
 * @param bundleClass 相应Bundle所存在的framework中，指定一个class类（例如CDDRouter）
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (UIImage *)getResourceOfImageWithName:(NSString *)imageName withClass:(Class)bundleClass withBundleName:(NSString *)bundleName;

@end

NS_ASSUME_NONNULL_END
