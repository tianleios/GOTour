//
//  ListCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/10.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell
+ (instancetype)createCellWithTableView:(UITableView *)tableView model:(id)model
{
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.select = model;
    return cell;
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imageV = [[UIImageView alloc]init];
        [self addSubview:_imageV];
        _imageV.layer.cornerRadius = kMargin;
        _imageV.layer.masksToBounds = YES;
        
        _titleLbl = [[UILabel alloc]init];
        [self addSubview:_titleLbl];
        
        _subTitle = [[UILabel alloc]init];
        [self addSubview:_subTitle];
        _subTitle.font = [UIFont systemFontOfSize:14];
        
        
        _whereView = [[TLWhereWhenLikeVIew alloc] init];
        [self addSubview:_whereView];
        
        
    }
    
    return self;
    
}

- (void)setSelect:(SelectModel *)select
{
    _select = select;
    
    _imageV.frame = CGRectMake(kMargin, kMargin/2, 1.46*kScreenWidth/3.9, kScreenWidth/3.9);
    UIImage *image = [UIImage imageNamed:@"UMS_nav_bar_bg_black@2x.png"];
    NSURL *url = [NSURL URLWithString:_select.bg_pic[0]];
    [_imageV sd_setImageWithURL:url placeholderImage:image];
    
    //标题
    CGFloat lblX = CGRectGetMaxX(_imageV.frame) + kMargin;
    _titleLbl.frame = CGRectMake(lblX, kMargin*2.5, kScreenWidth - lblX, 17);
    _titleLbl.text = _select.title;
    //子标题
    CGFloat subY = CGRectGetMaxY(_titleLbl.frame) + kMargin*2.5;
    _subTitle.frame = CGRectMake(lblX, subY, kScreenWidth - lblX, 13);
    _subTitle.text = _select.sub_title;
    //
    CGFloat whereY = CGRectGetMaxY(_subTitle.frame) + kMargin*2.5;
    
    _whereView.style = TLWhereStyle;
    _whereView.frame = CGRectMake(lblX, whereY, kScreenWidth - lblX, 10);
    _whereView.selectM = _select;
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
