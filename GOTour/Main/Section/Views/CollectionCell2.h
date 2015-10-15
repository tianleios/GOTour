//
//  CollectionCell2.h
//  旅行
//
//  Created by 磊 田 on 15/10/1.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLWhereWhenLikeVIew.h"
@class collectionCell2Frame;
@interface CollectionCell2 : UITableViewCell


@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel *shortDesclbl;

@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UILabel *subTitleLbl;

//时间 日期
@property (nonatomic, strong) TLWhereWhenLikeVIew *bootomView;

@property (nonatomic, strong) collectionCell2Frame *frameModel;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
