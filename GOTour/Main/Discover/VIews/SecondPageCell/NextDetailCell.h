//
//  NextDetailCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "DetailCellFrame.h"

typedef void(^NextBlock)(void);
@interface NextDetailCell : UITableViewCell

@property (nonatomic, strong) DetailModel *detailModel;

@property (nonatomic, strong) DetailCellFrame *frameM;

@property (nonatomic, copy) NextBlock nextBlock;

+ (instancetype)createCellWithTableView:(UITableView *)tableView block:(NextBlock) block;
@end
