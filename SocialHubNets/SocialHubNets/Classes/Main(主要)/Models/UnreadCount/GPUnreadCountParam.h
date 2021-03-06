//
//  GPUnreadCountParam.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPUnreadCountParam : NSObject

/*access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得*/
@property (nonatomic, copy) NSString *access_token;

/*uid	false	int64	需要查询的用户ID*/
@property (nonatomic, copy) NSString *uid;

@end
