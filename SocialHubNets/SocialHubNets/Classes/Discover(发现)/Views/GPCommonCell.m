//
//  GPCommonCell.m
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPCommonCell.h"
#import "GPCommonItem.h"
#import "GPCommonSwitchItem.h"
#import "GPCommonArrowItem.h"
#import "GPCommonLabelItem.h"
#import "GPCommonCheckItem.h"
#import "GPBadgeView.h"

@interface GPCommonCell()

@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UISwitch *rightSwitch;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *rightCheck;
@property (nonatomic, strong) GPBadgeView *badgeValue;

@end

@implementation GPCommonCell

- (UIImageView *)rightArrow
{
    if(_rightArrow == nil)
    {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch*)rightSwitch
{
    if(_rightSwitch == nil)
    {
        _rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel*)rightLabel
{
    if(_rightLabel == nil)
    {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
    }
    return _rightLabel;
}

- (UIImageView*)rightCheck
{
    if(_rightCheck == nil)
    {
        _rightCheck = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _rightCheck;
}

- (GPBadgeView*)badgeValue
{
    if(_badgeValue == nil)
    {
        _badgeValue = [[GPBadgeView alloc] init];
    }
    return _badgeValue;
}

+(id)cellWithTableView:(UITableView*)tableView
{
    NSString *className = NSStringFromClass([self class]);
    GPCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if(cell == nil)
    {
        cell = [[GPCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:className];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 设置标题字体
        self.textLabel.font = [UIFont systemFontOfSize:17];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        // 设置背景色
        self.backgroundColor = [UIColor clearColor];
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - 调整子控件的位置

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

#pragma mark - setter

- (void)setIndexPath:(NSIndexPath*)indexPath RowsInSection:(NSInteger)rows
{
    // 1. 取出背景view
    UIImageView *bgView = (UIImageView*)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView*)self.selectedBackgroundView;
    
    // 2. 设置背景图片
    if(rows == 1)
    {
        bgView.image = [UIImage resizedImageName:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImageName:@"common_card_background_highlighted"];
    }
    else if(indexPath.row == 0)
    {
        bgView.image = [UIImage resizedImageName:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImageName:@"common_card_top_background_highlighted"];
    }
    else if(indexPath.row == rows - 1)
    {
        bgView.image = [UIImage resizedImageName:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImageName:@"common_card_bottom_background_highlighted"];
    }
    else
    {
        bgView.image = [UIImage resizedImageName:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImageName:@"common_card_middle_background_highlighted"];
    }
//    self.backgroundView = bgView;
//    self.selectedBackgroundView = selectedBgView;
    
}

// 如果平移, header 和 footer会被覆盖掉, 所以虽好设置contentInset
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += -25;
//    [super setFrame:frame];
//    
//}

- (void)setItem:(GPCommonItem *)item
{
    _item = item;
    
    // 1. 设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2. 设置右边的内容
    if(item.badgeValue) // 紧急通知
    {
        self.badgeValue.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeValue;
    }
    else if([item isKindOfClass:[GPCommonArrowItem class]])
    {
        self.accessoryView = self.rightArrow;
    }
    else if ([item isKindOfClass:[GPCommonSwitchItem class]])
    {
        self.accessoryView = self.rightSwitch;
    }
    else if ([item isKindOfClass:[GPCommonLabelItem class]])
    {
        GPCommonLabelItem *labelItem = (GPCommonLabelItem*)item;
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [self.rightLabel.text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(150, self.rightLabel.font.lineHeight)];
        self.accessoryView = self.rightLabel;
    }
    else if ([item isKindOfClass:[GPCommonCheckItem class]])
    {
        self.accessoryView = self.rightCheck;
    }
    else
    {
        self.accessoryView = nil;
    }
}

@end
