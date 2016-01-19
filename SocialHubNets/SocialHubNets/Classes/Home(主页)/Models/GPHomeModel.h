//
//  GPHomeModel.h
//  我的微博
//
//  Created by qianfeng on 16/1/11.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 根节点
@interface GPHomeModel : NSObject

/** 	string 	好友显示名称*/
@property (nonatomic, strong) NSString *name;
/** 	string 	用户头像地址(中国) 50x50像素*/
@property (nonatomic, strong) NSString *profile_image_url;
/** 	mbtype 	会员类型*/
@property (nonatomic, assign) NSInteger mbtype;
/** 	mbrank 	会员等级*/
@property (nonatomic, assign) NSInteger mbrank;

@property (nonatomic, assign, getter = isVip, readonly) BOOL isVip;

@end

// 根节点的statused节点
@interface GPStatuses : NSObject

/** 	string 	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSAttributedString *attributeText;

/** 	string 	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 	object 	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) GPHomeModel *user;

/** 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细*/
@property (nonatomic, strong) GPStatuses *retweeted_status;
/** 	bool 	是否是转发微博 详细*/
@property (nonatomic, assign) BOOL retweeted;

/** 	int 	转发数*/
@property (nonatomic, assign) int reposts_count;

/** 	 int 	评论数*/
@property (nonatomic, assign) int comments_count;

/** 	 int 	表态数*/
@property (nonatomic, assign) int attitudes_count;

/** 	 object 	微博配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是GPPhoto模型*/
@property (nonatomic, strong) NSArray *pic_urls;
/** 	 bool 	这个数据表示转发微博的工具条是否显示在正文中(首页)*/
@property (nonatomic, assign, getter=isDetail) BOOL detail;

@end

// pic_urls节点的模型
@interface GPPhoto : NSObject
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;

@end

