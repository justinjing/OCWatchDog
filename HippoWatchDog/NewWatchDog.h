//
//  NewWatchDog.h
//  HippoWatchDog
//
//  Created by justinjing on 2017/8/13.
//  Copyright © 2017年 justinjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewWatchDog : NSObject

+ (instancetype)shareInstance;

- (void)start;
- (void)stop;

@end
