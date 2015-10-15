//
//  SelectionCell.m
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "SelectionCell.h"
#import "SelectTopBut.h"
#import "ReferrerModel.h"
#import "SelectModel.h"
#import "NSString+Ext.h"
#import "UILableTextWhite.h"

#import "TLWhereWhenLikeVIew.h"
#define bottmFont [UIFont systemFontOfSize:15]

@interface TLWhereWhenLikeVIew()


@end
@implementation SelectionCell

+ (instancetype)createCelllWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"qqqq";
    SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SelectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _topBut = [[SelectTopBut alloc]init];
        [self addSubview:_topBut];
        [_topBut addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *image = [[UIImageView alloc]init];
        _bigImage = image;
        [self.contentView addSubview:_bigImage];
        //图片标题
        _title = [[UILableTextWhite alloc]init];
        [self.bigImage addSubview:_title];
        //子标题
        _subTitle = [[UILableTextWhite alloc]init];
        [self.bigImage addSubview:_subTitle];
        
        _shortDesc = [[UILabel alloc]init];
        [self.contentView addSubview:_shortDesc];
        _shortDesc.font = [UIFont systemFontOfSize:15];
        _shortDesc.numberOfLines = 0;
        
        _bootomView = [[TLWhereWhenLikeVIew alloc]init];
        [self addSubview:_bootomView];
        
                  }
    return self;
}
-(void)setSelectFrame:(SelectFrame *)selectFrame
{
    _selectFrame = selectFrame;
    
    SelectModel *_selectModel = selectFrame.selectM;
   

    //1.把上传者即用户的信息传进来 头部but

    ReferrerModel *refModel = _selectModel.referrer;
     _topBut.frame = _selectFrame.topButFrame;
    _topBut.referrerModel = refModel;
   

    //2.中部图片及 标题
    NSString *urlS = _selectModel.bg_pic[0];
    NSURL *url = [NSURL URLWithString:urlS];
    [_bigImage sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
      // 尺寸
    _bigImage.frame = _selectFrame.imageFrame;
      //标题
    
    _title.text = _selectModel.title;
    _title.font = [UIFont boldSystemFontOfSize:20];
    _title.frame = _selectFrame.titleFrame;
    
    //设置显示行数
     _title.backgroundColor = [UIColor clearColor];
    _subTitle.backgroundColor = [UIColor clearColor];
    _subTitle.text = _selectModel.sub_title;
    _subTitle.frame = _selectFrame.subtitleFrame;

    //3.底部简介
    NSString *bottomStr = _selectModel.short_desc;

    _shortDesc.frame = _selectFrame.shortDescFrame;
    _shortDesc.text = bottomStr;
   _shortDesc.font = [UIFont systemFontOfSize:15];
    _shortDesc.numberOfLines = 0;
    
    //3.1 最底部小 收藏人数 目的地
    
    _bootomView.frame = _selectFrame.wwFrame;
    
    _bootomView.style = TLWhereLikeStyle;
    _bootomView.selectM = _selectModel;
   

}
-(void)tapAction
{
    _topButBlock();

}
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
@end
