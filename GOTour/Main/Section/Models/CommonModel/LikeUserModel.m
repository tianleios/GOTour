//
//  LikeUserModel.m
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "LikeUserModel.h"

@implementation LikeUserModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"userID":@"id"
             };
}
@end
