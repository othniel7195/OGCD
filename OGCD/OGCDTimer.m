//
//  OGCDTimer.m
//  OGCD
//
//  Created by 赵锋 on 15/9/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OGCDTimer.h"
#import "OGCDQueue.h"
@interface OGCDTimer ()
@property(nonatomic, strong, readwrite)dispatch_source_t dispatchSource;
@end

@implementation OGCDTimer

- (instancetype) initWithQueue:(OGCDQueue *)queue
{
    self = [super init];
    if (self) {
        
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.dispatchQueue);
    }
    return self;
}
- (void)event:(dispatch_block_t)block timeInterval:(NSTimeInterval)interval
{
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), interval*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, ^{
        block();
    });
}
- (void)start
{
    dispatch_resume(self.dispatchSource);
}
- (void)destroy
{
    dispatch_source_cancel(self.dispatchSource);
}
@end
