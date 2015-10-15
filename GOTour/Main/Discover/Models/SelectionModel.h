//
//  SelectionModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface SelectionModel : BaseModel



@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *destination;

@property (nonatomic, strong) NSNumber *ID;
//标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
//背景图片 第一张就在里面
@property (nonatomic, copy) NSString *bg_pic;
@property (nonatomic, strong) NSNumber *bg_color;

@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, copy) NSString *short_desc;
@end
