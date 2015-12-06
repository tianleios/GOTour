//
//  ThemeNextCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModel.h"
@class  TLWhereWhenLikeVIew;

@interface ThemeNextCell : UITableViewCell

@property (nonatomic, weak) UIImageView *imageV;

@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UILabel *subTitleLbl;


@property (nonatomic, strong) SelectModel *selectM;
//时间 日期
@property (nonatomic, strong) TLWhereWhenLikeVIew *bootomView;

@property (nonatomic, assign) BOOL isLike;

/**
 * 是否是本地图片
 */
@property (nonatomic, strong) UIImage *imageCache;

+(instancetype)createCellWithTableView:(UITableView *)tableView;

@end
