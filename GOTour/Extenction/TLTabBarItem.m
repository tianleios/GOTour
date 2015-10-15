//
//  TLTabBarItem.m
//  旅行
//
//  Created by 磊 田 on 15/9/21.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLTabBarItem.h"

@implementation TLTabBarItem



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView   = [[UIImageView alloc]init];
        
        _imageView.contentMode =  UIViewContentModeScaleAspectFit;
        _imageView.frame = CGRectMake(0, 5, kScreenWidth/4, 30);
        
        _lable  = [[UILabel alloc]init];
        
        
        [self addSubview:_imageView];
        [self addSubview:_lable];
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = [title copy];
        
        _title = title;
        _lable.text = title;
        _lable.font = [UIFont systemFontOfSize:10];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.frame = CGRectMake(0,40, kScreenWidth/4,5);
        _lable.textColor = [UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:1];
        
    }
    
    
    
}
-(void)setImageName:(NSString *)imageName
{
    //    if (_imageName != imageName) {
    
    _imageName = [imageName copy];
    UIImage *image = [UIImage imageNamed:imageName];
    _imageView.image = image;
    
    //    }
    
}


@end
