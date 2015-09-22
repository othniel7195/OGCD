//
//  OGCDGroup.h
//  OGCD
//
//  Created by 赵锋 on 15/9/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OGCDGroup : NSObject

@property(nonatomic, strong, readonly)dispatch_group_t dispatchGroup;

- (instancetype) init;

/**
 *  enter 和 leave group的次数必须一致
 */
- (void) enter;
- (void) leave;
- (void) wait;
- (void) wait:(NSTimeInterval)sec;
@end
