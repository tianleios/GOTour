//
//  ImageTextBut.m
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ImageTextBut.h"

@interface ImageTextBut()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *lable;


@end
@implementation ImageTextBut

+(instancetype)createButWithImage:(UIImage *)image title:(NSString *)title frame:(CGRect)frame   scale:(CGFloat)scale
{
    ImageTextBut *but = [[ImageTextBut alloc] initWithFrame:frame];

    but.imageV.image = image;
    but.lable.text = title;
    CGFloat h = but.frame.size.height;
    but.imageV.frame = CGRectMake(0, 0, but.frame.size.width, h*scale);
    
    but.lable.frame = CGRectMake(0, h*scale - 5, but.frame.size.width,h*(1-scale)+2);

    return but;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageV = [[UIImageView alloc]init];

        _imageV.layer.masksToBounds = YES;
        _imageV.contentMode =  UIViewContentModeScaleAspectFill;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        _lable  = [[UILabel alloc]init];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.font = [UIFont systemFontOfSize:12];
        [self addSubview:_imageV];
        [self addSubview:_lable];

        
    }
    return self;
}
-(void)setText:(NSString *)text
{

    _lable.text = text;
}
@end
