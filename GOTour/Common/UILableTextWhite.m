//
//  UILableTextWhite.m
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "UILableTextWhite.h"

@implementation UILableTextWhite

-(instancetype)init
{
    if (self = [super init]) {
        self.textColor = [UIColor whiteColor];
       self.font = [UIFont boldSystemFontOfSize:13];
        self.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
//        [UIFont fontWithName:@"Helvetica-Bold" size:20]
    }

    return self;
}
@end
