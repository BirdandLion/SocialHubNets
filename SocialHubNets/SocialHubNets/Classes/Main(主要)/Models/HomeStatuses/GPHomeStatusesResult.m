//
//  GPHomeStatusesResult.m
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPHomeStatusesResult.h"
#import "MJExtension.h"
#import "GPHomeModel.h"

@implementation GPHomeStatusesResult

- (NSDictionary*)objectClassInArray
{
    return @{@"statuses" : [GPStatuses class]};
}

@end
