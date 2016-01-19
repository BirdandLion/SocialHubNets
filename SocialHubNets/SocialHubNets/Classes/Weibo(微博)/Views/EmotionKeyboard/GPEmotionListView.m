//
//  GPEmotionListView.m
//  我的微博
//
//  Created by qianfeng on 16/1/14.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPEmotionListView.h"
#import "GPEmotionGridView.h"

#define GPEmotionMaxRows    3
#define GPEmotionMaxCols    7
#define GPEmotionMaxCountPerPage    (GPEmotionMaxRows * GPEmotionMaxCols - 1)

@interface GPEmotionListView() <UIScrollViewDelegate>

// 创建UIScrollView
@property (nonatomic, weak) UIScrollView *scrollView;
// 创建UIPageControl
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation GPEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 1. 创建UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        self.scrollView = scrollView;
        
        // 2. 创建UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        self.pageControl = pageControl;
    }
    return self;
}

// 设置子空间的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. 设置pageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 40;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2. 设置scrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 3. 设置scrollView的子控件frame
    CGFloat gridViewW = self.scrollView.width;
    CGFloat gridViewH = self.scrollView.height;
    NSInteger count = self.pageControl.numberOfPages;
    self.scrollView.contentSize = CGSizeMake(count * gridViewW, 0);
    for(int i=0; i<count; i++)
    {
        GPEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridViewW;
        gridView.height = gridViewH;
        gridView.x = i * gridViewW;
    }
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;

    // 设置总页数
    NSInteger totalPages = (emotions.count + GPEmotionMaxCountPerPage - 1) / GPEmotionMaxCountPerPage;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    self.pageControl.hidesForSinglePage = YES;
//    self.pageControl.hidden = totalPages <= 1;
    
    
    // 获取scrollView的子控件数目
    NSInteger currentGridViewCount = self.scrollView.subviews.count;
    
    // 添加新的子控件
    for(int i=0; i<totalPages; i++)
    {
        GPEmotionGridView *gridView = nil;
        if(i >= currentGridViewCount) // 说明gridview的个数不够
        {
            gridView = [[GPEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
        }
        else  // 复用子控件
        {
            gridView = self.scrollView.subviews[i];
        }
        
        // 设置每页多少个
        NSInteger loc = i * GPEmotionMaxCountPerPage;
        NSInteger len = GPEmotionMaxCountPerPage;
        if(loc + len > emotions.count)
        {
            len = emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;
    }
    
    // 隐藏不需要的gridView
    for(int i=(int)totalPages; i<self.scrollView.subviews.count; i++)
    {
        GPEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(self.scrollView.contentOffset.x / self.scrollView.width + 0.5);
}

@end
