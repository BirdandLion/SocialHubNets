//
//  GPCommonCell.h
//  我的微博
//
//  Created by qianfeng on 16/1/17.
//  Copyright (c) 2016年 kelvin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPCommonItem;

@interface GPCommonCell : UITableViewCell

// cell的数据
@property (nonatomic, strong) GPCommonItem *item;
// cell在第几行
- (void)setIndexPath:(NSIndexPath*)indexPath RowsInSection:(NSInteger)rows;

+(id)cellWithTableView:(UITableView*)tableView;

@end
