//
//  zqMd5.h
//  kpPlan
//
//  Created by rw on 15-3-11.
//  Copyright (c) 2015年 rw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zqMd5 : NSObject
+ (NSString *)md5_32:(NSString *)str;
//md5 16位加密 （大写）
+ (NSString *)md5_16:(NSString *)str;
//md5 16位加密 （小写）
+ (NSString *) md5_16_low:(NSString *)str;
@end
