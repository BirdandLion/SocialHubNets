//
//  GPCommonItem.h
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  用一个模型来描述每行的信息, 图标,子标题,右边的样式(箭头,数字,开关,打钩)

#import <Foundation/Foundation.h>

@interface GPCommonItem : NSObject

/*
 * 图标
 */
@property (nonatomic, strong) NSString *icon;
/*
 * 标题
 */
@property (nonatomic, strong) NSString *title;
/*
 * 子标题
 */
@property (nonatomic, strong) NSString *subtitle;
/*
 * 紧急数
 */
@property (nonatomic, strong) NSString *badgeValue;
// 点击这行cell, 需要调用哪个控制器
@property (nonatomic, assign) Class destVcClass;
// 点击cell调用的block
@property (nonatomic, copy) void (^operation)();

+ (id)itemWithTitle:(NSString*)title icon:(NSString*)icon;
+ (id)itemWithTitle:(NSString*)title;

@end
