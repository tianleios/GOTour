//
//  MainCollectionModel.m
//  旅行
//
//  Created by 磊 田 on 15/9/19.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "MainCollectionModel.h"
#import "CollectionModel.h"

@implementation MainCollectionModel

+(NSDictionary *)objectClassInArray
{
    return @{
             @"collectionArray" : [CollectionModel class]
             };
}
+(NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{
             @"collectionArray":@"collections"
             };

}
//-(instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self == [super init]) {
//
//        self.num = dict[@"num"];
//        self.type = dict[@"type"];
//        
//        NSArray *tempArray = dict[@"collections"];
//        _clmArray = [[NSMutableArray alloc]initWithCapacity:tempArray.count];
//        
//        for (NSDictionary *tempDict in tempArray) {
//            CollectionModel *tempModel =[[CollectionModel alloc]initWithDictionary:tempDict];
//            [_clmArray addObject:tempModel];
//        }
//        
//    }
//
//    return self;
//}

@end
