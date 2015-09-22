//
//  OGCDQueue.h
//  OGCD
//
//  Created by 赵锋 on 15/9/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGCDGroup;

@interface OGCDQueue : NSObject

@property (nonatomic, strong, readonly) dispatch_queue_t dispatchQueue;

#pragma mark -- 初始化
/**
 *  创建 串行队列
 *
 *  @return
 */
- (instancetype) init;
/**
 *  初始化串行队列
 *
 *  @return
 */
- (instancetype) initSerial;
/**
 *  初始化并行队列
 *
 *  @return
 */
- (instancetype) initConcurrent;


#pragma mark -- 执行相关操作

- (void) execute:(dispatch_block_t)block;
/**
 *  延迟执行
 *
 *  @param block
 *  @param sec 延迟的时间  秒
 */
- (void) execute:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec;

- (void) syncExecute:(dispatch_block_t)block;
/**
 *  要使用自己创建的并发线程池  否则是普通的async
 *
 *  @param block
 */
- (void) barrierExecute:(dispatch_block_t)block;
/**
 *  要使用自己创建的并发线程池  否则是普通的sync
 *
 *  @param block
 */
- (void) syncBarrierExecute:(dispatch_block_t)block;
/**
 *  暂停
 */
- (void) suspend;
/**
 *  恢复,重新开始
 */
- (void) resume;

#pragma mark -- 操作当前应用的main队列和 global 队列

+ (void) executeInMainQueue:(dispatch_block_t)block;
+ (void) executeInMainQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec;
+ (void) executeInGlobalQueue:(dispatch_block_t)block;
+ (void) executeInGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec;
+ (void) executeInHighPriorityGlobalQueue:(dispatch_block_t)block;
+ (void) executeInHighPriorityGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec;
+ (void) executeInLowPriorityGlobalQueue:(dispatch_block_t)block;
+ (void) executeInLowPriorityGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec;
+ (void) executeBackgroundPriorityGlobalQueue:(dispatch_block_t)block;
+ (void) executeBackgroundPriorityGlobalQueue:(dispatch_block_t)block afterDelay:(NSTimeInterval)sec;

#pragma mark --- 获取系统队列

+ (OGCDQueue *)mainQueue;
+ (OGCDQueue *)globalQueue;
+ (OGCDQueue *)highPriorityGlobalQueue;
+ (OGCDQueue *)lowPriorityGlobalQueue;
+ (OGCDQueue *)backgroundPriorityGlobalQueue;

#pragma mark ---- CGDGroup

- (void) execute:(dispatch_block_t)block inGroup:(OGCDGroup *)group;
/**
 *
 *  监听  线程组
 */
- (void) notify:(dispatch_block_t)block inGroup:(OGCDGroup *)group;

@end
