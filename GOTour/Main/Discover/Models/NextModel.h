//
//  NextModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface NextModel : BaseModel


@property (nonatomic, strong) NSNumber *ID;
//标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
//背景图片 第一张就在里面
@property (nonatomic, copy) NSString *bg_pic;
@property (nonatomic, strong) NSNumber *bg_color;
@property (nonatomic, strong) NSNumber *title_notshown;


@end
