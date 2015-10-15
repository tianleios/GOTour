//
//  ArticleModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface ArticleModel : BaseModel


@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, strong) NSString *bg_pic;

@property (nonatomic, strong) NSNumber *bg_color;

@property (nonatomic, strong) NSNumber *title_notshown;
@end
