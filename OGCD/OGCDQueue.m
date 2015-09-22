//
//  OGCDQueue.m
//  OGCD
//
//  Created by 赵锋 on 15/9/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OGCDQueue.h"
#import "OGCDGroup.h"
static OGCDQueue *mainQueue;
static OGCDQueue *globalQueue;
static OGCDQueue *highPriorityGlobalQueue;
static OGCDQueue *lowPriorityGlobalQueue;
static OGCDQueue *backgroundPriorityGlobalQueue;

@interface OGCDQueue ()

@property (nonatomic, strong, readwrite) dispatch_queue_t dispatchQueue;
@end

@implementation OGCDQueue

+ (OGCDQueue *)mainQueue
{
    return mainQueue;
}

+ (OGCDQueue *)globalQueue
{
    return globalQueue;
}

+ (OGCDQueue *)highPriorityGlobalQueue
{
    return highPriorityGlobalQueue;
}

+ (OGCDQueue *)lowPriorityGlobalQueue
{
    return lowPriorityGlobalQueue;
}

+ (OGCDQueue *)backgroundPriorityGlobalQueue
{
    return backgroundPriorityGlobalQueue;
}

+ (void)initialize
{
    if (self == [OGCDQueue self]) {
        
        mainQueue = [[OGCDQueue alloc] init];
        mainQueue.dispatchQueue = dispatch_get_main_queue();
        
        globalQueue = [OGCDQueue new];
        globalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        highPriorityGlobalQueue = [OGCDQueue new];
        highPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        
        lowPriorityGlobalQueue = [OGCDQueue new];
        lowPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
        
        backgroundPriorityGlobalQueue = [OGCDQueue new];
        backgroundPriorityGlobalQueue.dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    }
}

#pragma mark -- 队列初始化
- (instancetype) init
{
    return [self initSerial];
}
- (instancetype) initSerial
{
    self = [super init];
    if (self) {
        
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
    
}
- (instancetype) initConcurrent
{
    self = [super init];
    if (self) {
        
        self.dispatchQueue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark --  当前应用自己的队列
+ (void) executeInMainQueue:(dispatch_block_t)block
{
    [[OGCDQueue mainQueue] execute:block];
}
+ (void) executeInMainQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec
{
    [[OGCDQueue mainQueue] execute:block afterDelay:sec];
}
+ (void) executeInGlobalQueue:(dispatch_block_t)block;
{
    [[OGCDQueue globalQueue] execute:block];
}
+ (void) executeInGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec
{
    [[OGCDQueue globalQueue] execute:block afterDelay:sec];
}
+ (void) executeInHighPriorityGlobalQueue:(dispatch_block_t)block
{
    [[OGCDQueue highPriorityGlobalQueue] execute:block];
}
+ (void) executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec
{
    [[OGCDQueue highPriorityGlobalQueue] execute:block afterDelay:sec];
}
+ (void) executeInLowPriorityGlobalQueue:(dispatch_block_t)block
{
    [[OGCDQueue lowPriorityGlobalQueue] execute:block];
}
+ (void) executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec
{
    [[OGCDQueue lowPriorityGlobalQueue] execute:block afterDelay:sec];
}
+ (void) executeBackgroundPriorityGlobalQueue:(dispatch_block_t)block
{
    [[OGCDQueue backgroundPriorityGlobalQueue] execute:block];
}
+ (void) executeBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec
{
    [[OGCDQueue backgroundPriorityGlobalQueue] execute:block afterDelay:sec];
}


#pragma mark -- 执行
- (void) execute:(dispatch_block_t)block
{
    dispatch_async(self.dispatchQueue, block);
}

- (void) execute:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*sec), self.dispatchQueue, block);
}

- (void) syncExecute:(dispatch_block_t)block
{
    dispatch_sync(self.dispatchQueue, block);
}

- (void) barrierExecute:(dispatch_block_t)block
{
    dispatch_barrier_async(self.dispatchQueue, block);
}

- (void) syncBarrierExecute:(dispatch_block_t)block
{
    dispatch_barrier_sync(self.dispatchQueue, block);
}

- (void) suspend
{
    dispatch_suspend(self.dispatchQueue);
}
- (void)resume
{
    dispatch_resume(self.dispatchQueue);
}

- (void) execute:(dispatch_block_t)block inGroup:(OGCDGroup *)group
{
    dispatch_group_async(group.dispatchGroup, self.dispatchQueue, block);
}

- (void) notify:(dispatch_block_t)block inGroup:(OGCDGroup *)group
{
    dispatch_group_notify(group.dispatchGroup, self.dispatchQueue, block);
}
@end
