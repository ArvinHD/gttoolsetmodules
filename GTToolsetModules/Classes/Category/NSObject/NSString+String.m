//
//  NSString+String.m
//  CDDCarSecondLoan
//
//  Created by zhouwei on 2018/10/18.
//  Copyright © 2018年 徐春雨. All rights reserved.
//

#import "NSString+String.h"

@implementation NSString (String)

#pragma mark - 中文转拼音
- (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

#pragma mark - 是否为网络资源
- (BOOL)isNetWorkSource {
    if([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]){
        return YES;
    }
    return NO;
}

#pragma mark - 时间戳转时间
- (NSString *) timeStringToDate {
    // timeStampString 是服务器返回的13位时间戳
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[self doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

#pragma mark ======根据身份证识别性别=======
- (NSInteger)genderOfIDNumber:(NSString *)IDNumber
{
    //  记录校验结果：0未知，1男，2女
    NSInteger result = 0;
    NSString *fontNumer = nil;

    if (IDNumber.length == 15)
    { // 15位身份证号码：第15位代表性别，奇数为男，偶数为女。
        fontNumer = [IDNumber substringWithRange:NSMakeRange(14, 1)];

    }else if (IDNumber.length == 18)
    { // 18位身份证号码：第17位代表性别，奇数为男，偶数为女。
        fontNumer = [IDNumber substringWithRange:NSMakeRange(16, 1)];
    }else
    { //  不是15位也不是18位，则不是正常的身份证号码，直接返回
        return result;
    }

    NSInteger genderNumber = [fontNumer integerValue];

    if(genderNumber % 2 == 1)
        result = 1;

    else if (genderNumber % 2 == 0)
        result = 2;
    return result;
}

#pragma mark ======根据身份证识别出生年月=======
-(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    if (numberStr.length == 15) {
        // 加权因子
        int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
        // 校验码
        unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
        
        NSMutableString *mString = [NSMutableString stringWithString:self];
        if ([self length] == 15) {
            [mString insertString:@"19" atIndex:6];
            long p = 0;
            const char *pid = [mString UTF8String];
            for (int i=0; i<=16; i++) {
                p += (pid[i]-48) * R[i];
            }
            int o = p%11;
            NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
            [mString insertString:string_content atIndex:[mString length]];
        }
        numberStr = (NSString *)mString;
    }
    
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    if (numberStr.length == 18) {
        //**截取前14位
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
        //**检测前14位否全都是数字;
        const char *str = [fontNumer UTF8String];
        const char *p = str;
        while (*p!='\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        if(!isAllNumber)
            return result;
        year = [numberStr substringWithRange:NSMakeRange(6, 4)];
        month = [numberStr substringWithRange:NSMakeRange(10, 2)];
        day = [numberStr substringWithRange:NSMakeRange(12,2)];
        [result appendString:year];
        [result appendString:@"-"];
        [result appendString:month];
        [result appendString:@"-"];
        [result appendString:day];
        return result;
    }
    return nil;

//    else{
//        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];//**检测前14位否全都是数字;
//        const char *str = [fontNumer UTF8String];
//        const char *p = str;
//        while (*p!='\0') {
//            if(!(*p>='0'&&*p<='9'))
//                isAllNumber = NO;
//            p++;
//
//        }
//        if(!isAllNumber)
//            return result;
//        year = [numberStr substringWithRange:NSMakeRange(6, 2)];
//        month = [numberStr substringWithRange:NSMakeRange(8, 2)];
//        day = [numberStr substringWithRange:NSMakeRange(10,2)];
//        [result appendString:year];
//        [result appendString:@"-"];
//        [result appendString:month];
//        [result appendString:@"-"];
//        [result appendString:day];
//        NSString* resultAll = result;
//        return resultAll;
//    }
}

#pragma mark - 时间戳转 YY-MM-DD HH:MM
-(NSString*)timeStampToDateString {
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[self doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

#pragma mark - UTC时间转字符串 YY-MM-DD HH:MM
-(NSString*)stringToDateString {
    struct tm tm;
    time_t t;
    strptime([self cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm";
    // new date
    NSString *newString = [format stringFromDate:date];
    return newString;
}

//将本地日期字符串转为UTC日期字符串
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

//将本地日期字符串转为UTC日期字符串
//可自行指定输入输出格式
+ (NSString *)getLocalDateFormateUTC:(NSString *)UTCDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dateFormatted = [dateFormatter dateFromString:UTCDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

#pragma mark 非空判断
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


///获取当前时间的时间戳,13位的
+(long long)getNowTimeStamp{
    long long time = [[NSDate date] timeIntervalSince1970]*1000;
//    NSString *time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    return time;
}
/**
 时间戳转换时间
 
 @param date 时间戳
 @param type 得到的时间类型 @"YYYY-MM-dd"，@"MM月dd日"
 @return 时间
 */
+(NSString*)datetime:(NSTimeInterval )date fromType:(NSString*)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *confromTimesp;
    
    [formatter setDateFormat:type];
    confromTimesp = [NSDate dateWithTimeIntervalSince1970:date/1000];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
/**
 时间转换时间戳
 
 @param time 时间
 @param type 时间类型 @"YYYY-MM-dd"，@"MM月dd日"
 @return 时间戳
 */
+(NSString*)getTimeStampFromTime:(NSString*)time type:(NSString*)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:type];
    NSDate* date = [formatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%d000",(int)[date timeIntervalSince1970]];
    return timeSp;
}
/**
 //     和当前时间比较
 //     1）1分钟以内 显示        :    刚刚
 //     2）1小时以内 显示        :    X分钟前
 //     3）当前时间之前或者昨天 显示      :    今天 09:30   昨天 09:30
 //     4）当前时间之前或者明天 显示      :    今天 09:30   明天 09:30
 //     5) 今年显示              :   09月12日
 //     6) 大于本年      显示    :    2013/09/09
 //
 //     @param dateString @"2016-04-04 20:21"
 //     @param formate    @"YYYY-MM-dd hh:mm"
 //     hh与HH的区别:分别表示12小时制,24小时制
 **/
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    @try {
    
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        //  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        //  取当前时间和转换时间两个日期对象的时间间隔
        //  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        // 再然后，把间隔的秒数折算成天数和小时数：
        NSString *dateStr = @"";
        if (time < 0) {
            if (time >= -60*60*24) {
                dateStr = @"明天";
                [dateFormatter setDateFormat:@"YYYY/MM/dd"];
                NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
                NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
                
                [dateFormatter setDateFormat:@"HH:mm"];
                if ([need_yMd isEqualToString:now_yMd]) {
                    //在同一天
                    dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }else{
                    //明天天
                    dateStr = [NSString stringWithFormat:@"明天 %@",[dateFormatter stringFromDate:needFormatDate]];
                }
            }else{
                [dateFormatter setDateFormat:@"yyyy"];
                NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
                NSString *nowYear = [dateFormatter stringFromDate:nowDate];
                
                if ([yearStr isEqualToString:nowYear]) {
                    ////  在同一年
                    [dateFormatter setDateFormat:@"MM月dd日"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
                }else{
                    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                    dateStr = [dateFormatter stringFromDate:needFormatDate];
                }
            }
        }
//        else if (time<=60) {  //// 1分钟以内的
//            dateStr = @"刚刚";
//        }else if(time<=60*60){  ////  一个小时以内的
//
//            int mins = time/60;
//            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
//
//        }
        else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
        

    } @catch (NSException *exception) {
        return @"";
    }
}


@end
