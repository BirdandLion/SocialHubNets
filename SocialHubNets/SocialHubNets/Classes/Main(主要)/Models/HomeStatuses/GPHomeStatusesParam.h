//
//  GPHomeStatusesParam.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPHomeStatusesParam : NSObject

/*access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得*/
@property (nonatomic, copy) NSString *access_token;
/*since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0*/
@property (nonatomic, assign) NSNumber *since_id;
/*max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0*/
@property (nonatomic, assign) NSNumber *max_id;
/*count	false	int	单页返回的记录条数，最大不超过100，默认为20*/
@property (nonatomic, assign) NSNumber *count;

@end

