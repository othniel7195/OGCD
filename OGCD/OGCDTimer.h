//
//  OGCDTimer.h
//  OGCD
//
//  Created by 赵锋 on 15/9/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OGCDQueue;

@interface OGCDTimer : NSObject

@property(nonatomic, strong, readonly)dispatch_source_t dispatchSource;

- (instancetype) initWithQueue:(OGCDQueue *)queue;

/**
 *
 *  @param interval 最小是秒级的设定
 */
- (void)event:(dispatch_block_t)block timeInterval:(NSTimeInterval)interval;
- (void)start;
- (void)destroy;
@end
