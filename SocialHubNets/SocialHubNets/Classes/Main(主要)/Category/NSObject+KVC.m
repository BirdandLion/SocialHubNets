//
//  NSObject+KVC.m
//  05-qq好友
//
//  Created by 哲 肖 on 15/12/16.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "NSObject+KVC.h"

@implementation NSObject (KVC)

+(id)objectWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
-(id)initWithDict:(NSDictionary *)dict
{
    if(self = [self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
