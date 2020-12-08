//
//  GTLoadResource.m
//  GTToolsetModules
//
//  Created by apple on 2020/9/3.
//

#import "GTLoadResource.h"

@implementation GTLoadResource

/*!
 * 根据bundleClass获取所在的Pod Bundle, 根据bundleName来获取资源文件所在的bundle
 *
 * @param bundleClass 相应Bundle所存在的framework中，指定一个class类（例如CDDRouter）
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (NSBundle *)getPodBundleWithClass:(Class)bundleClass withBundleName:(NSString *)bundleName
{
    //根据Class类在Bundle中查找所属的Bundle
    NSBundle *podBundle = [NSBundle bundleForClass:bundleClass.self];
    //根据podSpec中配置的资源文件的名称来获取相应的bundle
    NSURL *bundleURL = [podBundle URLForResource:bundleName withExtension:@"bundle"];
    //根据URL来转换为NSBundle实例
    NSBundle *urlBundle = [NSBundle bundleWithURL:bundleURL];
    
    return urlBundle;
}

/*!
 * 获取xib资源文件
 *
 * @param nibClass 相应Bundle所存在的framework中，指定一个xib class类
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (UINib *)getResourceOfNibClass:(Class)nibClass withBundleName:(NSString *)bundleName
{
    return [UINib nibWithNibName:NSStringFromClass(nibClass) bundle:[GTLoadResource getPodBundleWithClass:nibClass withBundleName:bundleName]];
}

/*!
 * 获取Plist资源数据
 *
 * @param plistName plist文件的名称 xx.plist
 * @param bundleClass 相应Bundle所存在的framework中，指定一个class类（例如CDDRouter）
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (NSDictionary *)getPlistInfoWithName:(NSString *)plistName withClass:(Class)bundleClass withBundleName:(NSString *)bundleName
{
    return [NSDictionary dictionaryWithContentsOfFile:[[GTLoadResource getPodBundleWithClass:bundleClass withBundleName:bundleName] pathForResource:plistName ofType:@"plist"]];
}

/*!
 * 获取图片资源文件
 *
 * @param imageName 图片的名称 xx.png
 * @param bundleClass 相应Bundle所存在的framework中，指定一个class类（例如CDDRouter）
 * @param bundleName 资源文件所存在的Bundle名称（pod库名称即可）
 */
+ (UIImage *)getResourceOfImageWithName:(NSString *)imageName withClass:(Class)bundleClass withBundleName:(NSString *)bundleName
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:imageName inBundle:[GTLoadResource getPodBundleWithClass:bundleClass withBundleName:bundleName] compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [UIImage imageWithContentsOfFile:[[GTLoadResource getPodBundleWithClass:bundleClass withBundleName:bundleName] pathForResource:imageName ofType:@"png"]];
#else
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:imageName inBundle:[GTLoadResource getPodBundleWithClass:bundleClass withBundleName:bundleName] compatibleWithTraitCollection:nil];
    }else {
        return [UIImage imageWithContentsOfFile:[[GTLoadResource getPodBundleWithClass:bundleClass withBundleName:bundleName] pathForResource:imageName ofType:@"png"]];
    }
#endif
}


@end
