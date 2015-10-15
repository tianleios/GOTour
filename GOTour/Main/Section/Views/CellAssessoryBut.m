//
//  CellAssessoryBut.m
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "CellAssessoryBut.h"

@implementation CellAssessoryBut

- (instancetype)initWithFrame:(CGRect)frame withType:(BOOL)flag
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (flag == YES) {
            //类型1 上下
            [self setImage:[UIImage imageNamed:@"activity_DownAccessory"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"activity_UpAccessory"] forState:UIControlStateSelected];
            [self addTarget:self action:@selector(actionYes:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            //类型2 向右
            [self setImage:[UIImage imageNamed:@"activity_RightAccessory"] forState:UIControlStateNormal];
           [self addTarget:self action:@selector(actionNo:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    return self;
}
-(void)actionYes:(CellAssessoryBut *)but
{
    but.selected = !but.selected;
    _block();
}
-(void)actionNo:(CellAssessoryBut *)but
{
    _block();

}
@end
