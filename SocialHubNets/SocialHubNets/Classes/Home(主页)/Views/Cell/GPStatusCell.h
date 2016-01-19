//
//  GPStatusCell.h
//  我的微博
//
//  Created by qianfeng on 16/1/13.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPStatusFrame;

@interface GPStatusCell : UITableViewCell

// cell子空间的frame
@property (nonatomic, strong) GPStatusFrame *statusFrame;

// 初始化cell
+ (id)statusCellWithTableView:(UITableView *)tableView;

@end
