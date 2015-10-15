//
//  DiscoverModel.m
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "DiscoverModel.h"
#import "CollectionModel.h"
#import "NextModel.h"

#import "TopSelectionModel.h"
#import "ArticleModel.h"
#import "TagModel.h"
//articles":Array[4],
//"top_selections":Array[5],
//"next_stops":Array[4],
//"collections":Array[20],
//"tags":Arr
@implementation DiscoverModel

+(NSDictionary *)objectClassInArray
{

    return @{
             @"articles":[ArticleModel class],
             @"top_selections":[TopSelectionModel class],
             @"next_stops":[NextModel class],
             @"collections":[CollectionModel class],
             @"tags":[TagModel class]

                 };

}
@end
