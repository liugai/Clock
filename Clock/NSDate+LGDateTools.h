//
//  NSDate+LGDateTools.h
//  MyReader
//
//  Created by 刘盖 on 2017/3/27.
//  Copyright © 2017年 liugai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LGDateTools)

//将日期转换为指定格式的字符串
+ (NSString *)stringFromDate:(NSDate *)date withMode:(NSString *)mode;


+ (NSArray *)arrayWithDate:(NSDate *)date;
@end
