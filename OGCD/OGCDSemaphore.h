//
//  OGCDSemaphore.h
//  OGCD
//
//  Created by 赵锋 on 15/9/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//
//  信号量
#import <Foundation/Foundation.h>

@interface OGCDSemaphore : NSObject

@property(nonatomic, strong, readonly) dispatch_semaphore_t dispatchSemaphore;

- (instancetype) initWithValue:(long)value;
/**
 *  发送信号量
 */
- (void) signal;
/**
 *  等待信号量 必须和发送配对使用
 */
- (void) wait;
- (void) wait:(NSTimeInterval)interval;

@end
