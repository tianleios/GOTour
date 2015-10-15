//
//  LoadMoreBut.m
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "LoadMoreBut.h"

@implementation LoadMoreBut

//activity_moreD.png
//
//activity_moreD2.png
+ (instancetype)createLoadMoreButtonWithFrame:(CGRect)frame flag:(BOOL)flag  actionBlock:(LoadMoreBlock)block
{
    LoadMoreBut *but = [[LoadMoreBut alloc]initWithFrame:frame flag:flag];
    but.block = block;
    return but;
}
- (instancetype)initWithFrame:(CGRect)frame flag:(BOOL)flag
{
    self = [super initWithFrame:frame];
    if (self) {
        
            _lbl = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 35, 15, 55, 20)];
            [self addSubview:_lbl];
            _lbl.textAlignment = NSTextAlignmentRight;
            _lbl.font = [UIFont systemFontOfSize:13];
        
        CGFloat x  = CGRectGetMaxX(_lbl.frame) + 5;
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(x, 20, 10, 10)];
            [self addSubview:_imageV];
        
        [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        if (flag == YES) {
            
            _imageV.image = [UIImage imageNamed:@"activity_moreD.png"];
            _lbl.text = @"更多内容";
            
        }else{
            
            _imageV.image = [UIImage imageNamed:@"activity_moreD2.png"];
            _lbl.text = @"收起内容";

        }
        

        

    }
    return self;
}
- (void)action:(LoadMoreBut *)but
{
    
   
   
    _block();
    
}
@end
