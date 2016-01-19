//
//  GPSendStatusParam.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSendStatusParam : NSObject

/* access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得 */
@property (nonatomic, copy) NSString *access_token;
/* status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字 */
@property (nonatomic, copy) NSString *status;

@end
