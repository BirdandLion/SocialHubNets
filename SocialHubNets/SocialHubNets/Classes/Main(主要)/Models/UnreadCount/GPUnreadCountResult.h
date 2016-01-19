//
//  GPUnreadCountResult.h
//  我的微博
//
//  Created by qianfeng on 16/1/12.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPUnreadCountResult : NSObject

/* status	int	新微博未读数 */
@property (nonatomic, assign) NSNumber *status;
/* follower	int	新粉丝数 */
@property (nonatomic, assign) NSNumber *follower;
/* cmt	int	新评论数 */
@property (nonatomic, assign) NSNumber *cmt;
/* dm	int	新私信数 */
@property (nonatomic, assign) NSNumber *dm;
/* mention_status	int	新提及我的微博数 */
@property (nonatomic, assign) NSNumber *mention_status;
/* mention_cmt	int	新提及我的评论数 */
@property (nonatomic, assign) NSNumber *mention_cmt;
/* group	int	微群消息未读数 */
@property (nonatomic, assign) NSNumber *group;
/* private_group	int	私有微群消息未读数 */
@property (nonatomic, assign) NSNumber *private_group;
/* notice	int	新通知未读数 */
@property (nonatomic, assign) NSNumber *notice;
/* invite	int	新邀请未读数 */
@property (nonatomic, assign) NSNumber *invite;
/* badge	int	新勋章数 */
@property (nonatomic, assign) NSNumber *badge;
/* photo	int	相册消息未读数 */
@property (nonatomic, assign) NSNumber *photo;

// 消息总数
- (NSInteger)messageCount;

// 所有消息数
- (NSInteger)totalCount;

@end
