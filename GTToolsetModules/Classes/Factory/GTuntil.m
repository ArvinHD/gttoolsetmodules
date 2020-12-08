//
//  GTuntil.m
//  GTToolsetModules
//
//  Created by apple on 2020/9/17.
//

#import "GTuntil.h"

@implementation GTuntil

+(NSInteger)getConfigureFont:(float)size{
    //读取缓存倍数 - 没有的话默认1
    YYCache *cache = [[YYCache alloc]initWithName:KFontCache];
    float scale = 1.0;
    BOOL isContains=[cache containsObjectForKey:@"fontsize"];
    if (isContains) {
        id vuale = [cache objectForKey:@"fontsize"];
        float fontM = [vuale floatValue];
        
        switch((int)(fontM)) {
            case 0: scale = 0.8; break;
            case 2: scale = 1.1; break;
            case 3: scale = 1.2; break;
            case 4: scale = 1.3; break;
            case 5: scale = 1.4; break;
            default:
                scale = 1.0;
                break;
        }
    }
    return ceil(size * scale);
}

@end
