//
//  CollectionModel.h
//  旅行
//
//  Created by 磊 田 on 15/9/19.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "MJExtension.h"

@interface CollectionModel : BaseModel<MJKeyValue>


@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *short_desc;
@property (nonatomic, copy) NSString *layout;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, strong) NSArray *bg_pic;//背景图片的url 可能有多个

@property (nonatomic, strong) NSNumber *bg_color;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *title_notshown;


@end
