//
//  ListCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/10.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModel.h"

#import "TLWhereWhenLikeVIew.h"

@interface ListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *subTitle;

@property (nonatomic, strong) TLWhereWhenLikeVIew *whereView;

@property (nonatomic, strong) SelectModel *select;


+ (instancetype)createCellWithTableView:(UITableView *)tableView model:(id)model;

@end
