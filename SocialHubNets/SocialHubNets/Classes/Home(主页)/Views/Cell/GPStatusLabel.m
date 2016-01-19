//
//  GPStatusLabel.m
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusLabel.h"
#import "GPLink.h"

#define GPLinkBackground    20000

@interface GPStatusLabel()

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *links;

@end

@implementation GPStatusLabel

- (NSMutableArray *)links
{
    if(_links == nil)
    {
        _links = [NSMutableArray array];
        // 搜索搜友的链接
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            
            NSString *linkText = attrs[GPLinkText];
            
            if(linkText == nil) return ;
            
            // 单个对象的所有链接
            NSMutableArray *rects = [NSMutableArray array];
            // 设置选中的文字
            self.textView.selectedRange = range;
            // 算出选中的字符范围的边框
            NSArray *selectedRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for(UITextSelectionRect *selectedRect in selectedRects)
            {
                if(selectedRect.rect.size.width == 0 || selectedRect.rect.size.height == 0)
                    continue;
                
                [rects addObject:selectedRect];
            }
            
            // 创建一个链接
            GPLink *link = [[GPLink alloc] init];
            link.text = linkText;
            link.range = range;
            link.rects = rects;
            
            [_links addObject:link];
        }];
    }
    return _links;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UITextView *textView = [[UITextView alloc] init];
        [self addSubview:textView];
        // 设置内部文字边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置不能和用户交互
        textView.userInteractionEnabled = NO;
        // 设置不可编辑
        textView.editable = NO;
        
        textView.backgroundColor = [UIColor clearColor];
        
        self.textView = textView;
        
    }
    return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    self.links = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

#pragma mark - 处理触摸事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    GPLink *touchingLink = [self touchingLinkWithPoint:point];
    
    [self showLinkBackground:touchingLink];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    GPLink *touchingLink = [self touchingLinkWithPoint:point];
    if(touchingLink)
    {
        // 说明手指在某个lianjie上面抬起来
        [[NSNotificationCenter defaultCenter] postNotificationName:GPLinkDidSelectedNotification object:nil userInfo:@{GPLinkText : touchingLink.text}];
    }
    
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}

#pragma mark - 链接背景处理

// 根据触摸点查看点击了哪个链接
- (GPLink*)touchingLinkWithPoint:(CGPoint)point
{
    __block GPLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(GPLink *link, NSUInteger idx, BOOL *stop) {
        for(UITextSelectionRect *selectedRect in link.rects)
        {
            if(CGRectContainsPoint(selectedRect.rect, point))
            {
                touchingLink = link;
                break;
            }
        }
    }];
    
    return touchingLink;
}

// 显示链接背景
- (void)showLinkBackground:(GPLink*)link
{
    for(UITextSelectionRect *selectedRect in link.rects)
    {
        UIView *bg = [[UIView alloc] init];
        bg.alpha = 0.3;
        bg.layer.cornerRadius = 3;
        bg.frame = selectedRect.rect;
        bg.backgroundColor = [UIColor greenColor];
        bg.tag = GPLinkBackground;
        [self insertSubview:bg atIndex:0];
    }
}

// 删除link的背景
- (void)removeAllLinkBackground
{
    for(UIView *subView in self.subviews)
    {
        if(subView.tag == GPLinkBackground)
        {
            [subView removeFromSuperview];
        }
    }
}


@end
