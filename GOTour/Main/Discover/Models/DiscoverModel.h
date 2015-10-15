//
//  DiscoverModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface DiscoverModel : BaseModel

//articles":Array[4],
//"top_selections":Array[5],
//"next_stops":Array[4],
//"collections":Array[20],
//"tags":Arr
@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSArray *top_selections;
@property (nonatomic, strong) NSArray *next_stops;
@property (nonatomic, strong) NSArray *collections;
@property (nonatomic, strong) NSArray *tags;




@end
