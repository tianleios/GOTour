//
//  CollectionCell2.m
//  旅行
//
//  Created by 磊 田 on 15/10/1.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "CollectionCell2.h"
#import "collectionCell2Frame.h"
#import "SelectModel.h"
@implementation CollectionCell2

+(instancetype)createCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:imageView];
        _imageV = imageView;
        
        UILabel *shortlbl = [[UILabel alloc]init];
        [self addSubview:shortlbl];
        _shortDesclbl = shortlbl;
        
        UILabel *titleLbl = [[UILabel alloc]init];
        [_imageV addSubview:titleLbl];
        _titleLbl = titleLbl;
        
        UILabel *subTitleLbl = [[UILabel alloc]init];
        [_imageV addSubview:subTitleLbl];
        _subTitleLbl = subTitleLbl;
        
        
        _bootomView = [[TLWhereWhenLikeVIew alloc]init];
        [_imageV addSubview:_bootomView];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
    }


    return self;
}

-(void)setFrameModel:(collectionCell2Frame *)frameModel
{
    if (_frameModel != frameModel) {
        _frameModel = frameModel;
        
        //图片
        _imageV.frame = _frameModel.imageVFrame;
        NSString *str = _frameModel.selectM.bg_pic[0];
        NSURL *url = [NSURL URLWithString:str];
        [_imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
        
        //简介
        _shortDesclbl.frame = _frameModel.shortDeseLblFrame;
        _shortDesclbl.font = kFont2;
        _shortDesclbl.text = _frameModel.selectM.short_desc;
        _shortDesclbl.numberOfLines = 0;
        _shortDesclbl.textAlignment = NSTextAlignmentLeft;
//        _shortDesclbl.textColor = [UIColor grayColor];
//        [UIColor]
        
        _shortDesclbl.backgroundColor = [UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:0.05];
        
        //剩余三项
        _titleLbl.frame = _frameModel.titleLblFrame;
        _titleLbl.text = _frameModel.selectM.title;
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:18];
     
        
        _subTitleLbl.frame = _frameModel.subTitleFrame;
        _subTitleLbl.text = _frameModel.selectM.sub_title;
        _subTitleLbl.textAlignment = NSTextAlignmentLeft;
        _subTitleLbl.font = [UIFont boldSystemFontOfSize:13];
        _subTitleLbl.textColor = [UIColor whiteColor];
        //最后一项
        _bootomView.frame = _frameModel.whereWhenFrame;
        _bootomView.style = TLWhereWhenStyle;
        _bootomView.selectM = _frameModel.selectM;
        
        
    }


}
@end
