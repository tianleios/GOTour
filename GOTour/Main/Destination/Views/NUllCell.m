//
//  NUllCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NUllCell.h"

@implementation NUllCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, self.frame.size.width, 20)];
        lbl.text = @"热门目的地";
        [self addSubview:lbl];
    }
    return self;
}
@end
