//
//  GPAccountModel.m
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPAccountModel.h"

@implementation GPAccountModel

+ (id)accountModelWithDict:(NSDictionary*)dict
{
    GPAccountModel *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 确定账号过期时间: 账号的创建时间加上有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:[account.expires_in doubleValue]];
    
    return account;
}

#pragma mark - NSCoding

// 当从文件中解析处一个对象时调用,在整个方法中写清楚怎么解析文件中的数据
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

// 将对象写入文件时调用,在整个方法中写清楚,要存储那些属性,以及怎样存储属性
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
