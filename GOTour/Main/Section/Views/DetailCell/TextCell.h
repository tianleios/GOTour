//
//  TextCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadCell.h"
@interface TextCell : UITableViewCell


@property (nonatomic, strong) DetailCellFrame *frameM;

+ (instancetype)createCellWith:(UITableView *)tableView;
@end
