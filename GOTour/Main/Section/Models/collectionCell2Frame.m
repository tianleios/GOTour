//
//  collectionCell2Frame.m
//  旅行
//
//  Created by 磊 田 on 15/10/1.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "collectionCell2Frame.h"
#import "SelectModel.h"
#import "NSString+Ext.h"
#define kImageHeight 220
@implementation collectionCell2Frame


-(void)setSelectM:(SelectModel *)selectM
{
    if (_selectM != selectM) {
        _selectM = selectM;
        [self calcuteframe:_selectM];
    }

    
}

-(void)calcuteframe:(SelectModel *)selectModel
{
    //图片
    _imageVFrame = CGRectMake(kMargin*2, 0, kScreenWidth - 4*kMargin , kImageHeight);
    //简介
    CGFloat shortY = CGRectGetMaxY(_imageVFrame) + kMargin;
    
    NSString *shortString = selectModel.short_desc;
    CGFloat shortH = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 6*kMargin, MAXFLOAT) string:shortString font:kFont2].height;

    _shortDeseLblFrame = CGRectMake(3*kMargin, shortY, kScreenWidth - 6*kMargin, shortH);
    //标题
    _titleLblFrame = CGRectMake(kMargin*3, kImageHeight*0.7, kScreenWidth - 4*kMargin, 25);
    //子标题
   CGFloat subY = CGRectGetMaxY(_titleLblFrame);
    _subTitleFrame = CGRectMake(kMargin*3, subY, kScreenWidth - 4*kMargin, 15);
    //时间 地点
    CGFloat wwY = CGRectGetMaxY(_subTitleFrame) + kMargin;
//    _wwlblFrame = CGRectMake(kMargin, wwY, kScreenWidth - 4*kMargin, 20);
    _whereWhenFrame = CGRectMake(kMargin*3 , wwY, kScreenWidth - kMargin, 20);
    
    _cellHeight = CGRectGetMaxY(_shortDeseLblFrame) + 4*kMargin;

}
@end
