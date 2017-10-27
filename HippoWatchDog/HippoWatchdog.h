//
//  HippoWatchdog.h
//  HippoWatchDog
//
//  Created by justinjing on 2017/8/12.
//  Copyright © 2017年 justinjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HippoWatchdog : NSObject

- (instancetype)initWiththreshold:(float)threshold  strictMode:(BOOL)stMode;

@end
