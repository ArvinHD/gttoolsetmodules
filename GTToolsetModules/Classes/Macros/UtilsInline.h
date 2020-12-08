//
//  Defines.h
//  photosDemo
//
//  Created by zhouwei on 2018/7/18.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

NS_INLINE BOOL NumberHasValue(id str) {
    
    if (![str isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if ([str isEqual:[NSNull null]]) {
        return NO;
    }
    return (str != nil) && (str != [NSNull null]);
}

NS_INLINE BOOL StringHasValue(id str) {
    
    // FIXME:
    if ([str isKindOfClass:[NSNumber class]]) {
        return NumberHasValue(str);
    }
    
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    return (str != nil) && (str != [NSNull null]) && (![str isEqualToString:@""] && (![str isEqualToString:@"(null)"]) && (![str isEqualToString:@"null"])) && (![str isEqual:[NSNull null]] && (![str isEqualToString:@"<null>"]));
}


NS_INLINE BOOL DictionaryHasValue(NSDictionary *dict)
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([dict isEqual:[NSNull null]] || !dict) {
        return NO;
    }
    
    NSArray * array = [dict allKeys];
    if ([array count]>0) {
        return YES;
    }else{
        return NO;
    };
}


NS_INLINE BOOL ArrayHasValue(NSArray *array)
{
  if (![array isKindOfClass:[NSArray class]]) {
    return NO;
  }
  if ([array count]>0) {
    return YES;
  }else{
    return NO;
  }
}

//获取当前控制器
NS_INLINE UIViewController* GetCurrentViewCon()
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else {
        result = window.rootViewController;
    }
    return result;
}

//获取当前拥有类型的控制器
NS_INLINE UIViewController* GetCurrentValidViewCon()
{
    UIViewController *superVC = GetCurrentViewCon();
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else {
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    }
    return superVC;
}

#endif /* Defines_h */
