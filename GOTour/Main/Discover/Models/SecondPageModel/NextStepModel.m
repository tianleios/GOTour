//
//  NextStepModel.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NextStepModel.h"
#import "DetailModel.h"
@implementation NextStepModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };


}
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"body":[DetailModel class]
             };
}
@end
