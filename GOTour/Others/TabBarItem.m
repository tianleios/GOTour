//
//  TabBarItem.m
//  旅行
//
//  Created by 磊 田 on 15/9/12.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView   = [[UIImageView alloc]init];
       
        _imageView.contentMode =  UIViewContentModeScaleAspectFit;

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
        
        _lable.backgroundColor = [UIColor orangeColor];
        _lable.font = [UIFont systemFontOfSize:8];
        
        _lable.textAlignment = NSTextAlignmentCenter;
        
        _lable.frame = CGRectMake(0,25, kScreenWidth/4,20);
        _lable.textColor = [UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:1];

    }
   


}
-(void)setImageName:(NSString *)imageName
{
//    if (_imageName != imageName) {
      _imageView.frame = CGRectMake(0, 0, kScreenWidth/4, 25);
        _imageName = [imageName copy];
        UIImage *image = [UIImage imageNamed:imageName];
        _imageView.image = image;
       
//    }
    
}
@end
