//
//  OGCDGroup.m
//  OGCD
//
//  Created by 赵锋 on 15/9/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OGCDGroup.h"

@interface OGCDGroup ()
@property (nonatomic, strong, readwrite)dispatch_group_t dispatchGroup;
@end

@implementation OGCDGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dispatchGroup = dispatch_group_create();
    }
    return self;
}

- (void)enter {
    dispatch_group_enter(self.dispatchGroup);
}

- (void)leave {
    dispatch_group_leave(self.dispatchGroup);
}

- (void)wait {
    dispatch_group_wait(self.dispatchGroup, DISPATCH_TIME_FOREVER);
}

- (void)wait:(NSTimeInterval)sec{
    dispatch_group_wait(self.dispatchGroup,dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*sec));
}

@end
