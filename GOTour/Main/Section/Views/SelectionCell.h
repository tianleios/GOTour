//
//  SelectionCell.h
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectFrame.h"

typedef void(^UserBlock)(void);

@class SelectModel;
@class SelectTopBut;
@class TLWhereWhenLikeVIew;

@interface SelectionCell : UITableViewCell

@property (nonatomic, strong) SelectTopBut *topBut;//顶部

@property (nonatomic, weak) UIImageView *bigImage;//中间图片
@property (nonatomic, strong) UILabel *title;//中间标题
@property (nonatomic, strong) UILabel *subTitle;//中间标题

@property (nonatomic, strong) UILabel *shortDesc;//底部详解

//@property (nonatomic, strong) SelectModel *selectModel;//数据模型
@property (nonatomic, strong) SelectFrame *selectFrame;//数据模型


@property (nonatomic, strong) UILabel *lbl;

@property (nonatomic, strong) TLWhereWhenLikeVIew *bootomView;

// 收藏人数 地点
//recommend_count activity_location
@property (nonatomic, copy)  UserBlock topButBlock;

+ (instancetype)createCelllWithTableView:(UITableView *)tableView;
@end
