
//  HippoWatchdog.m
//  HippoWatchDog
//
//  Created by justinjing on 2017/8/12.
//  Copyright © 2017年 justinjing. All rights reserved.
//

#import "HippoWatchdog.h"
#import "HippoBacktraceLogger.h"


@interface PingThread : NSThread

@property (nonatomic, assign) float threshold;
@property (nonatomic, assign) BOOL pingTaskIsRunning;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, copy) void (^handler)();

@end


@implementation PingThread

- (instancetype)init:(float)threshold handler:(void(^)())handler{
    self = [super init];
    if (self) {
        self.threshold = threshold;
        self.handler = handler;
        self.pingTaskIsRunning = false;
        self.semaphore = dispatch_semaphore_create(0);
    }
    return  self;
}

- (void)main{
    [super main];
    while (! self.cancelled) {
        self.pingTaskIsRunning = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pingTaskIsRunning = NO;
            dispatch_semaphore_signal(self.semaphore);
        });
        
        [NSThread sleepForTimeInterval:self.threshold];
        
        if (self.pingTaskIsRunning) {
            self.handler();
        }
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    }
}


@end

@interface HippoWatchdog ()

@property (nonatomic, strong) PingThread *pingThread;

@end

@implementation HippoWatchdog

- (void)startObserve:(float)threshold handler:(void(^)())watchdogFiredCallback{
    self.pingThread = [[PingThread alloc] init:threshold handler:watchdogFiredCallback];
    [self.pingThread start];
}

- (instancetype)initWiththreshold:(float)threshold  strictMode:(BOOL)stMode {
    self = [super init];
    if (self) {
    NSString *message = [NSString stringWithFormat:@"Main thread was blocked for %.2f s",threshold];
        [self startObserve:threshold handler:^{
        HIPPO_BSLOG_MAIN;
        if (stMode) {
            NSAssert(NO,message);
        }else{
            NSLog(@"watch dog assert-----%@",message);
        }
    }];
    }
   return  self;
}

- (void)dealloc {
    [self.pingThread cancel];
}
                                     
@end
