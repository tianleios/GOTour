//
//  ContentModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
//url":"http://data.qinker.com/image/original/f2/52/6d/f2526d739e0a5e01a1e3bd68c782a479.jpg",
//"width":650,
//"height":400,
//"size":"126.8 KB",
//"image_id":28631
#import "BaseModel.h"
@interface ContentModel : BaseModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, copy) NSString *head;
@property (nonatomic, copy) NSString *text;


//根据发现界面 后来又添加的属性 需要 吧
@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *destination;

@property (nonatomic, strong) NSNumber *ID;
//标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
//背景图片 第一张就在里面
@property (nonatomic, copy) NSString *bg_pic;
@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, copy) NSString *short_desc;
@end
