//
//  SelectModel.m
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "SelectModel.h"
#import "ReferrerModel.h"
#import "DetailModel.h"
#import "ExpenseModel.h"
#import "LikeUserModel.h"
@implementation SelectModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };

}

+(NSDictionary *)objectClassInArray
{
    return @{
             @"details" : [DetailModel class],
             @"expense" : [ExpenseModel class],
             @"like_user": [LikeUserModel class]
             };
}


@end
