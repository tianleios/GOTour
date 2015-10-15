//
//  DetailCellFrame.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "DetailCellFrame.h"
#import "DetailModel.h"
#import "ContentModel.h"
#import "NSString+Ext.h"
#import "NSString+Ext.h"
@implementation DetailCellFrame

-(void)setDetailM:(DetailModel *)detailM
{
    _detailM = detailM;
//    NSLog(@"%@",_detailM.content.text);
    
    //标题
    if ([detailM.type isEqualToString:@"head"]) {
        
        NSString *headText = _detailM.content.head;
        
      CGSize size = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 6*kMargin ,MAXFLOAT) string:headText font:[UIFont systemFontOfSize:23]];
        
        _headFrame = CGRectMake(kDetailCellMargin, kMargin,kScreenWidth - 2*kDetailCellMargin, size.height + kMargin);
        _rowHeight =  size.height +2*kMargin ;
    }
    //简介
    if ([detailM.type isEqualToString:@"text"]) {
        NSString *string = _detailM.content.text;
        
       CGSize s =  [NSString calculateStringSize:CGSizeMake(kScreenWidth - 2*kDetailCellMargin, MAXFLOAT) string:string font:kDetailTextFont];
        _textFrame = CGRectMake(kDetailCellMargin, kMargin, s.width, s.height);
        _rowHeight = s.height + 2*kMargin;
        
        
    }
    
    //图片
    if ([detailM.type isEqualToString:@"pic"]) {
        
        CGFloat height = [_detailM.content.height floatValue];
        CGFloat width = [_detailM.content.width floatValue];
        
        CGFloat scale = height/width;
        CGFloat W = kScreenWidth - 2*kDetailCellMargin;
        CGFloat H = W * scale ;
        _imageFrame = CGRectMake(kDetailCellMargin, kMargin, W,H);
        _rowHeight = H + 2*kMargin;
        
    }
    if ([detailM.type isEqualToString:@"referrer"]) {
        
        _rowHeight = 90;
        
    }

    //如果有可进一步点击的选项 那就进行加载
    if ([detailM.type isEqualToString:@"recomm"]) {
        
        CGFloat W = kScreenWidth - 2*kDetailCellMargin;
        CGFloat H = 180;
        _nextImageFrame = CGRectMake(kDetailCellMargin, kMargin, W,H);
        _rowHeight = H;
        
    }

}
@end
