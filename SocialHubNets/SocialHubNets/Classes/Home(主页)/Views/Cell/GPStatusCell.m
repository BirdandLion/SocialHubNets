//
//  GPStatusCell.m
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import "GPStatusCell.h"
#import "GPStatusDetailView.h"
#import "GPStatusToolbar.h"

#import "GPStatusFrame.h"
#import "GPHomeModel.h"

@interface GPStatusCell()

@property (nonatomic, weak) GPStatusDetailView *detailView;
@property (nonatomic, weak) GPStatusToolbar *toolbarView;

@end

@implementation GPStatusCell

+ (id)statusCellWithTableView:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([GPStatusCell class]);
    [tableView registerClass:[GPStatusCell class] forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] )
    {
        [self setupDetailView];
        [self setupToolbar];
        
        // 3. 设置cell颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 添加微博具体内容
- (void)setupDetailView
{
    GPStatusDetailView *detailView = [[GPStatusDetailView alloc] init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}

// 添加工具条
- (void)setupToolbar
{
    GPStatusToolbar *toolbarView = [[GPStatusToolbar alloc] init];
    [self.contentView addSubview:toolbarView];
    self.toolbarView = toolbarView;
}

- (void)setStatusFrame:(GPStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1. 微博具体内容的frame数据
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    // 2. 底部工具条的frame
    self.toolbarView.frame = statusFrame.toolbarFrame;
    self.toolbarView.status = statusFrame.status;
}

@end
