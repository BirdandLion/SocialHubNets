//
//  NSObject+KVC.h
//  05-qq好友
//
//  Created by 哲 肖 on 15/12/16.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVC)

+(id)objectWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
