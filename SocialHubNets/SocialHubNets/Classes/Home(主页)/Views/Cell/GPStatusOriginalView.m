//
//  GPStatusOriginalView.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusOriginalView.h"
#import "UIImageView+WebCache.h"
#import "GPStatusPhotosView.h"
#import "GPStatusLabel.h"

@interface GPStatusOriginalView()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) GPStatusLabel * textLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak) UILabel * timeLabel;
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) GPStatusPhotosView *photosView;

@end

@implementation GPStatusOriginalView

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        // 1. 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        nameLabel.font = GPStatusOriginalNameFont;
        self.nameLabel = nameLabel;
        
        // 2. 正文
        GPStatusLabel *textLabel = [[GPStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3. 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        [self addSubview:sourceLabel];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = GPStatusOriginalSourceFont;
        self.sourceLabel = sourceLabel;
        
        // 4. 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = GPStatusOriginalTimeFont;
        self.timeLabel = timeLabel;
        
        // 5. 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        vipView.contentMode = UIViewContentModeCenter;
        self.vipView = vipView;
        
        // 7. 配图相册
        GPStatusPhotosView *photosView = [[GPStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(GPStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    
    GPStatuses *status = originalFrame.status;
    
    // 0. 昵称
    self.nameLabel.text = status.user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    
    // 1. 设置会员等级
    if(status.user.isVip)
    {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%ld", status.user.mbrank]];
    }
    else
    {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    // 2. 正文
    self.textLabel.attributedText = status.attributeText;
    self.textLabel.frame = originalFrame.textFrame;

    // 3. 时间
    self.timeLabel.text = status.created_at;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + GPStatusCellInset * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:GPStatusOriginalTimeFont maxSize:CGSizeMake(150, timeY)];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize}; // 转换成frame
    
    // 4. 来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + GPStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:GPStatusOriginalSourceFont maxSize:CGSizeMake(150, sourceY)];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize}; // 转换成frame
    
    // 5. 头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = originalFrame.iconFrame;
    
    // 6.配图相册
    if(originalFrame.status.pic_urls.count)
    {
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.hidden = NO;
    }
    else
    {
        self.photosView.hidden = YES;
    }
}

@end
