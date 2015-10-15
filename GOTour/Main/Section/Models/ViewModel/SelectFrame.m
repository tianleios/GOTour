//
//  SelectFrame.m
//  tianleilnl
//
//  Created by 磊 田 on 15/10/11.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "SelectFrame.h"
#import "NSString+Ext.h"
@implementation SelectFrame

-(void)setMainCM:(MainCollectionModel *)mainCM
{
    _mainCM = mainCM;
    
    _scrrollFrame = CGRectMake(0, 0, kScreenWidth, bigImageHeight);
    _rowHeight = 240;

}
-(void)setSelectM:(SelectModel *)selectM
{
    _selectM = selectM;
    
    //顶部按钮
    _topButFrame = CGRectMake(0, 0, kScreenWidth, tabBarHeight);

    //中间图片
    CGFloat bigY = CGRectGetMaxY(_topButFrame);
    _imageFrame = CGRectMake(0, bigY, kScreenWidth, bigImageHeight);
    
    //标题
    _titleFrame = CGRectMake(10, bigImageHeight*4.5/6, kScreenWidth, 30);

    //子标题
    CGFloat subY = CGRectGetMaxY(_titleFrame);
    _subtitleFrame = CGRectMake(10, subY, kScreenWidth, 20);
    //底部简介
    NSString *bottomStr = _selectM.short_desc;
    
    CGSize size = CGSizeMake(kScreenWidth - 20, MAXFLOAT);
    CGSize descSize = [NSString calculateStringSize:size string:bottomStr font:[UIFont systemFontOfSize:15]];
    
    CGFloat descY = CGRectGetMaxY(_imageFrame) + kMargin;
    _shortDescFrame = CGRectMake(10, descY, descSize.width, descSize.height);
    
    //底部标签
    
    CGFloat bootomY = CGRectGetMaxY(_shortDescFrame);
    
    _wwFrame = CGRectMake(0, bootomY, kScreenWidth - 15, 20);
    
    
    //4.确定尺寸
    _rowHeight = CGRectGetMaxY(_wwFrame) + kMargin;


}
//_selectModel = selectModel;
//
////1.把上传者即用户的信息传进来 头部but
//
//ReferrerModel *refModel = selectModel.referrer;
//_topBut.referrerModel = refModel;
////尺寸
////    _topBut.frame = CGRectMake(0, 0, kScreenWidth, tabBarHeight);
////2.中部图片及 标题
//NSString *urlS = selectModel.bg_pic[0];
//NSURL *url = [NSURL URLWithString:urlS];
//[_bigImage sd_setImageWithURL:url];
//// 尺寸
//CGFloat bigY = CGRectGetMaxY(_topBut.frame);
//_bigImage.frame = CGRectMake(0, bigY, kScreenWidth, bigImageHeight);
////标题
//
//_title.text = selectModel.title;
//_title.font = [UIFont boldSystemFontOfSize:20];
//_title.frame = CGRectMake(10, bigImageHeight*4/6, kScreenWidth, 30);
//
////设置显示行数
//_title.backgroundColor = [UIColor clearColor];
//_subTitle.backgroundColor = [UIColor clearColor];
//_subTitle.text = selectModel.sub_title;
//CGFloat subY = CGRectGetMaxY(_title.frame);
//_subTitle.frame = CGRectMake(10, subY, kScreenWidth, 30);
//
////3.底部简介
//NSString *bottomStr = selectModel.short_desc;
//
//CGSize size = CGSizeMake(kScreenWidth - 20, MAXFLOAT);
//CGSize descSize = [NSString calculateStringSize:size string:bottomStr font:bottmFont];
//_shortDesc.text = bottomStr;
//_shortDesc.font = bottmFont;
//_shortDesc.numberOfLines = 0;
//
//CGFloat descY = CGRectGetMaxY(_bigImage.frame) + kMargin;
//_shortDesc.frame = CGRectMake(10, descY, descSize.width, descSize.height);
//
////3.1 最底部小 收藏人数 目的地
//CGFloat bootomY = CGRectGetMaxY(_shortDesc.frame);
//
//_bootomView.frame = CGRectMake(0, bootomY, kScreenWidth - 15, 20);
//
//_bootomView.style = TLWhereLikeStyle;
//_bootomView.selectM = _selectModel;
////4.确定尺寸
//_selectModel.cellHeight = CGRectGetMaxY(_bootomView.frame) + kMargin;
//
//}

@end
