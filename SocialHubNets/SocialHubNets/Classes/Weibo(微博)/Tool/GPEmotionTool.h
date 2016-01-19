//
//  GPEmotionTool.h
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//  管理表情数据: 加载表情, 最近使用

#import <Foundation/Foundation.h>

///Users/qianfeng/Library/Developer/CoreSimulator/Devices/936D48A1-B1A5-49B2-850A-827AA19ACA6C/data/Containers/Data/Application/0505A19F-08C8-486B-8841-4E11AE6A0927/Documents

@class GPEmotion;

@interface GPEmotionTool : NSObject

+ (NSArray*)defaultEmotions;
+ (NSArray*)emojiEmotions;
+ (NSArray*)lxhEmotions;
+ (NSArray*)recentEmotions;
+ (void)addRecentEmotion:(GPEmotion*)emotion;
// 根据表情的文字描述,找出对应的表情对象
+ (GPEmotion*)emotionWithDisc:(NSString *)desc;

@end
