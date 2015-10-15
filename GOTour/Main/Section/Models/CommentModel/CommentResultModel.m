//
//  CommentResultModel.m
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "CommentResultModel.h"

@implementation CommentResultModel

+(NSDictionary *)replacedKeyFromPropertyName
{

    return @{
             @"commentID":@"id"
             };
}

@end
