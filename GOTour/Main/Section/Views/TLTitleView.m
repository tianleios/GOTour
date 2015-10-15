//
//  TLTitleView.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLTitleView.h"

@interface TLTitleView()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *subLbl;

@end
@implementation TLTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //主标题
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.textColor = [UIColor whiteColor];
        [self addSubview:_titleLbl];
       
        //子标题
        _subLbl = [[UILabel alloc]init];
        _subLbl.textColor = [UIColor whiteColor];
        [self addSubview:_subLbl];
     
    }
    return self; 
}

-(void)addTitle:(NSString *)title subTitle:(NSString *)subTitle topBootomScale:(CGFloat)scale titleFont:(NSInteger)font1 subTitleFont:(NSInteger)font2
{
    self.titleLbl.text = title;
    self.subLbl.text = subTitle;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _titleLbl.frame = CGRectMake(0, 0, width, height*scale);
    
    CGFloat y = CGRectGetMaxY(_titleLbl.frame);
    _subLbl.frame = CGRectMake(0, y, width, height*(1-scale));
    _titleLbl.font = [UIFont boldSystemFontOfSize:font1];
    _subLbl.font = [UIFont boldSystemFontOfSize:font2];
}

@end
