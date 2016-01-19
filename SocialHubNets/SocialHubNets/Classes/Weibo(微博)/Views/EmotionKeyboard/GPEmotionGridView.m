//
//  GPEmotionGridView.m
//  我的微博
//
//  Created by qianfeng on 16/1/15.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionGridView.h"
#import "GPEmotion.h"
#import "GPEmotionView.h"
#import "GPEmotionPopView.h"
#import "GPEmotionTool.h"

@interface GPEmotionGridView()

// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;
// 当前页所有显示的表情
@property (nonatomic, copy) NSMutableArray *emotionsArray;
// 弹出的表情
@property (nonatomic, strong) GPEmotionPopView *emotionPopView;

@end

@implementation GPEmotionGridView

- (NSMutableArray*)emotionsArray
{
    if(_emotionsArray == nil)
    {
        _emotionsArray = [NSMutableArray array];
    }
    return _emotionsArray;
}

- (GPEmotionPopView*)emotionPopView
{
    if(_emotionPopView == nil)
    {
        _emotionPopView = [GPEmotionPopView emotionPopView];
    }
    return _emotionPopView;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton = deleteButton;
        
        // 添加长按的手势识别器
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 表情总数
    NSInteger count = emotions.count;
    // 可复用的表情总数
    NSInteger currentEmotionsViewCount = self.emotionsArray.count;
    for(int i=0; i<count; i++)
    {
        GPEmotionView *emotionView = nil;
        
        if(i >= currentEmotionsViewCount)  // 控件不够用
        {
            emotionView = [[GPEmotionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionsArray addObject:emotionView];
        }
        else // 复用控件
        {
            emotionView = self.emotionsArray[i];
        }
        
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    
    // 隐藏多余的emotionView
    for(int i=(int)count; i<currentEmotionsViewCount; i++)
    {
        GPEmotionView *emotionView = self.emotionsArray[i];
        emotionView.hidden = YES;
    }
    
    // 添加删除按钮
    [self addSubview:self.deleteButton];
    
    // 重新布局子控件
    [self setNeedsLayout];
}

// 根据触摸到返回对应的表情
- (GPEmotionView*)emotionViewWithPoint:(CGPoint)point
{
    // 检测触发点落在哪个表情上
    __block GPEmotionView *foundEmotionView = nil;
    [self.subviews enumerateObjectsUsingBlock:^(GPEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        if(CGRectContainsPoint(emotionView.frame, point) && (emotionView.hidden == NO))
        {
            foundEmotionView = emotionView;
            // 停止遍历
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

// 触发了长按手势
- (void)longPress:(UILongPressGestureRecognizer*)recognizer
{
    // 1. 取出触发点
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    // 2. 检测触发点落在哪个表情上
    GPEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)  // 手松开了
    {
        [self.emotionPopView dismiss];
        
        // 选中表情
        [self selectedEmotion:emotionView.emotion];
    }
    else // 手没有松开
    {
        [self.emotionPopView showFromEmotionView:emotionView];
    }
}

// 监听表情按钮的点击
- (void)emotionClick:(GPEmotionView*)emotionView
{
    [self.emotionPopView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emotionPopView dismiss];
        
        // 发出一个选中表情的通知
        [self selectedEmotion:emotionView.emotion];
    }); 
}

// 发选中表情的通知
- (void)selectedEmotion:(GPEmotion*)emotion
{
    if(emotion == nil) return;
    
    // 存储选中的表情
    [GPEmotionTool addRecentEmotion:emotion];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GPEmotionDidSelectedNotification object:nil userInfo:@{GPSelectedEmotion : emotion}];
}

// 点击了删除按钮
- (void)deleteButtonClick
{    
    [[NSNotificationCenter defaultCenter] postNotificationName:GPEmotionDidDeletedNotification object:nil userInfo:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置表情的frame
    NSInteger count = self.emotions.count;
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    CGFloat emotionViewW = (self.width - leftInset * 2) / GPEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / GPEmotionMaxRows;
    for(int i=0; i<count; i++)
    {
        UIButton *emotionView = self.emotionsArray[i];
        emotionView.x = leftInset + (i % GPEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / GPEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    // 设置删除按钮的frame
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - self.deleteButton.width - leftInset;
    self.deleteButton.y = self.height - self.deleteButton.height;
}

@end

