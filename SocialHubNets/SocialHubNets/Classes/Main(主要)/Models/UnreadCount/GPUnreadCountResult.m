//
//  GPUnreadCountResult.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPUnreadCountResult.h"

@implementation GPUnreadCountResult

- (NSInteger)messageCount
{
    NSInteger count = [self.cmt integerValue] + [self.dm integerValue] + [self.mention_cmt integerValue] + [self.mention_status integerValue];
    return count;
}

- (NSInteger)totalCount
{
    return [self.status integerValue] + self.messageCount + [self.follower integerValue];
}

@end
