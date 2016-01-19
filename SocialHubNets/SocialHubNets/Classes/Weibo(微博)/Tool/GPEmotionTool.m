//
//  GPEmotionTool.m
//  我的微博
//
//  Created by qianfeng on 16/1/16.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionTool.h"
#import "GPEmotion.h"
#import "MJExtension.h"

#define GPRecentEmotionsFilePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]

@interface GPEmotionTool()

@end

@implementation GPEmotionTool

// 默认表情 ()
static NSArray *_defaultEmotions; 
//emoij表情
static NSArray *_emojiEmotions;
//浪小花表情
static NSArray *_lxhEmotions;
//最近表情
static NSMutableArray *_recentEmotions;

// 默认表情 (类方法的懒加载)
+ (NSArray*)defaultEmotions
{
    if(_defaultEmotions == nil)
    {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"default.plist" ofType:nil];
        _defaultEmotions = [GPEmotion objectArrayWithFile:plist];
        [self.defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/defalut"];
    }
    return _defaultEmotions;
}

// emoji表情
+ (NSArray*)emojiEmotions
{
    if(_emojiEmotions == nil)
    {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"emoji.plist" ofType:nil];
        _emojiEmotions = [GPEmotion objectArrayWithFile:plist];
    }
    return _emojiEmotions;
}

// 浪小花表情
+ (NSArray*)lxhEmotions
{
    if(_lxhEmotions == nil)
    {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"lxh.plist" ofType:nil];
        _lxhEmotions = [GPEmotion objectArrayWithFile:plist];
        [self.defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (NSMutableArray*)recentEmotions
{
    if(_recentEmotions == nil)
    {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:GPRecentEmotionsFilePath];
        if(_recentEmotions == nil)
        {
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

+ (void)addRecentEmotion:(GPEmotion*)emotion
{
    // 加载最近的表情数据 (防止直接使用_recentEmotions插入, 而_recentEmotions为空, 导致数据永远无法插入)
    [self recentEmotions];
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    // 添加最新的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 存储到沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:GPRecentEmotionsFilePath];
}

+ (GPEmotion*)emotionWithDisc:(NSString *)desc
{
    if(!desc) return nil;
    
    __block GPEmotion *foundEmotion = nil;
    
    [self.defaultEmotions enumerateObjectsUsingBlock:^(GPEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht])
        {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    if(foundEmotion) return foundEmotion;
    
    [self.lxhEmotions enumerateObjectsUsingBlock:^(GPEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht])
        {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    return foundEmotion;
}

@end
