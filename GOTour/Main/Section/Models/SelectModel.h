//
//  SelectModel.h
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

//"id":2699,
//"owner":Object{...},
//"title":"风情万种的花街",
//"sub_title":"东京江户神乐坂徒步之旅",
//"bg_pic":Array[5],
//"bg_color":9276027,
//"is_liked":0,
//"like_count":0,
//"like_user":Array[0],
//"collections":Array[1],
//"start_date":"2015-08-01",
//"end_date":"2015-12-28",
//"type":"Recomm",
//"open_time":"",
//"tag":Object{...},
//"address":"日本东京",
//"itinerary":Object{...},
//"price":"￥298",
//"expense":Array[2],
//"short_desc":"看过东
//referrer":Object{...},  发布这条信息的人  即用户信息
//"schedule":"开始日期：2015-08-01 结束日期：2015-12-28",
//"order_url":"http://www.haiwan.com/tourDetail/98203.html",
//"website":"",
//"details":Array[21],
//"location":Object{...},
//"destination":"日本, 东京",
//"contact":"国内 400-010-0917 境外 +8610 64160917",
//"brief":"",
//"album":Object{...},
//"online":15

////  "type":"Collection"
#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class ReferrerModel;
@class LocationModel;

@interface SelectModel : BaseModel<MJKeyValue>

//用户信息
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, assign) CGFloat height;

//出自哪里
@property (nonatomic, strong) ReferrerModel *referrer;

@property (nonatomic, copy) NSString *type;
//其他
@property (nonatomic, copy) NSString *schedule;
@property (nonatomic, copy) NSString *order_url;
@property (nonatomic, copy) NSString *website;
//详情
@property (nonatomic, strong) NSArray *details;

@property (nonatomic, strong) LocationModel *location;

@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, strong) NSDictionary *album;
@property (nonatomic, strong) NSNumber *online;


//@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSDictionary *owner;
//标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
//背景图片 第一张就在里面
@property (nonatomic, strong) NSArray *bg_pic;
@property (nonatomic, strong) NSNumber *bg_color;
@property (nonatomic, strong) NSNumber *is_liked;
@property (nonatomic, strong) NSNumber *like_count;
//收藏者
@property (nonatomic, strong) NSArray *like_user;

@property (nonatomic, strong) NSArray *collections;

@property (nonatomic, copy) NSString *start_date;
@property (nonatomic, copy) NSString *end_date;

@property (nonatomic, copy) NSString *open_time;
@property (nonatomic, strong) NSDictionary *tag;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSDictionary *itinerary;
@property (nonatomic, copy) NSString *price;
//花费
@property (nonatomic, strong) NSArray *expense;
@property (nonatomic, copy) NSString *short_desc;


//cel里的高度
@property (nonatomic, assign) CGFloat cellHeight;

//-(instancetype)initWithDistionary:(NSDictionary *)dict;


@end
