//
//  GPAccountModel.h
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPAccountModel : NSObject<NSCoding>


@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *expires_in;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSDate *expires_time;
@property (nonatomic, strong) NSString *name;

+ (id)accountModelWithDict:(NSDictionary*)dict;

@end
