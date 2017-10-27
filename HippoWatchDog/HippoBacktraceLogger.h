//
//  HippoBacktraceLogger.h
//  HippoWatchDog
//
//  Created by justinjing on 2017/8/12.
//  Copyright © 2017年 justinjing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HIPPO_BSLOG       NSLog(@"%@",[HippoBacktraceLogger bs_backtraceOfCurrentThread]);
#define HIPPO_BSLOG_MAIN  NSLog(@"%@",[HippoBacktraceLogger bs_backtraceOfMainThread]);
#define HIPPO_BSLOG_ALL   NSLog(@"%@",[HippoBacktraceLogger bs_backtraceOfAllThread]);

@interface HippoBacktraceLogger : NSObject

+ (NSString *)bs_backtraceOfAllThread;
+ (NSString *)bs_backtraceOfCurrentThread;
+ (NSString *)bs_backtraceOfMainThread;
+ (NSString *)bs_backtraceOfNSThread:(NSThread *)thread;

@end
