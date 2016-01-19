//
//  GPStatusBastToolbar.m
//  我的微博
//
//  Created by qianfeng on 16/1/18.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusBastToolbar.h"
#import "GPHomeModel.h"

@interface GPStatusBastToolbar()


@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, weak) UIButton *retweetedBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *unlikeBtn;

@end

@implementation GPStatusBastToolbar

- (NSMutableArray*)btns
{
    if(_btns == nil)
    {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.retweetedBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.unlikeBtn = [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
    }
    return self;
}

// 添加按钮
- (UIButton *)setupBtnWithIcon:(NSString*)icon title:(NSString*)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置高亮背景
    [btn setBackgroundImage:[UIImage resizeImageWithImageName:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    // 高亮时不加暗图片显示
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.btns addObject:btn];
    
    [self addSubview:btn];
    
    return btn;
}

// 设置子空间frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSInteger btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for(int i=0; i<btnCount; i++)
    {
        UIButton *btn = self.btns[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = btnW * i;
        btn.y = 0;
    }
}

// 设置微博转发 评论 赞等的数目
- (void)setStatus:(GPStatuses *)status
{   
    [self setBtnTitle:self.retweetedBtn defaultTitlt:@"转发" count:status.reposts_count];
    [self setBtnTitle:self.commentBtn defaultTitlt:@"评论" count:status.comments_count];
    [self setBtnTitle:self.unlikeBtn defaultTitlt:@"赞" count:status.attitudes_count];
    
}

// 设置按钮互动的数目
- (void)setBtnTitle:(UIButton*)button defaultTitlt:(NSString*)defaultTitle count:(int)count
{
    if(count > 10000)
    {
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    else if(count > 0)
    {
        defaultTitle = [NSString stringWithFormat:@"%d", count];
    }
    
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

@end
