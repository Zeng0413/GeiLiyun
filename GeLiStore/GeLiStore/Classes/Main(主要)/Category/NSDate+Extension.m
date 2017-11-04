//
//  NSDate+Extension.m
//  ZDXweibo
//
//  Created by zdx on 2017/5/8.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calender components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;

}
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:timeZone];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    
    NSString *nowStr = [fmt stringFromDate:nowDate];
    
    NSDate *date = [fmt dateFromString:dateStr];
    
    nowDate = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;

}
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday{
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:timeZone];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}
@end
