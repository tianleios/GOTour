//
//  NSString+Ext.m
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

+(CGSize)calculateStringSize:(CGSize)size string:(NSString *)string font:(UIFont *)font
{
    CGSize stringSize;
    NSDictionary *dict = @{
                           NSFontAttributeName:font
                           };
    stringSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return stringSize;
}
@end
