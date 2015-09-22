//
//  OGCDSemaphore.m
//  OGCD
//
//  Created by 赵锋 on 15/9/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OGCDSemaphore.h"

@interface OGCDSemaphore ()
@property(nonatomic, strong, readwrite)dispatch_semaphore_t dispatchSemaphore;
@end

@implementation OGCDSemaphore

- (instancetype)initWithValue:(long)value {
    self = [super init];
    if (self) {
        self.dispatchSemaphore = dispatch_semaphore_create(value);
    }
    return self;
}

- (void)signal {
    dispatch_semaphore_signal(self.dispatchSemaphore);
}

- (void)wait {
    dispatch_semaphore_wait(self.dispatchSemaphore, DISPATCH_TIME_FOREVER);
}

- (void)wait:(NSTimeInterval)sec {
    dispatch_semaphore_wait(self.dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, sec*NSEC_PER_SEC));
}

@end
