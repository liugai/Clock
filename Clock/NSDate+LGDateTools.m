//
//  NSDate+LGDateTools.m
//  MyReader
//
//  Created by 刘盖 on 2017/3/27.
//  Copyright © 2017年 liugai. All rights reserved.
//

#import "NSDate+LGDateTools.h"

@implementation NSDate (LGDateTools)

+ (NSString *)stringFromDate:(NSDate *)date withMode:(NSString *)mode{
    //若date为空，返回nil
    if (!date) {
        return @"";
    }
    
    NSString *modeTemp = mode;
    if (!mode) {
        modeTemp = @"yyyyMMddHHmmss";
    }
    //设置格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:modeTemp];
    
    //将date对象转换为字符串返回
    return [formatter stringFromDate:date];
}

+ (NSArray *)arrayWithDate:(NSDate *)date{
    NSString *dateString = [self stringFromDate:date withMode:@"yyyy年MM月dd日-HH:-mm:-ss"];
    NSArray *arrayTemp = [dateString componentsSeparatedByString:@"-"];
    return arrayTemp;
}

@end
