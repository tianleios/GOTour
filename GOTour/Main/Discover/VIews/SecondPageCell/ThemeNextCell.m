//
//  ThemeNextCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ThemeNextCell.h"
#import "TLWhereWhenLikeVIew.h"
@implementation ThemeNextCell

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
- (void)setSelectM:(SelectModel *)selectM
{
    _selectM = selectM;
    
   //图片
    _imageV.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/1.6);
    _imageV.clipsToBounds = YES;
    if (_imageCache == nil) {
        
        NSURL *url = [NSURL URLWithString:_selectM.bg_pic[0]];
        [_imageV sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    }else{
        
        _imageV.image = _imageCache;
       
    }
   
    
    CGFloat h = _imageV.bounds.size.height;
    CGFloat w = _imageV.bounds.size.width;
    
    //标题
    CGFloat offX = 2*kMargin;
    _titleLbl.frame = CGRectMake(offX,h*0.65, w, 25);
    _titleLbl.text = _selectM.title;
    _titleLbl.font = [UIFont boldSystemFontOfSize:18];
    _titleLbl.textAlignment = NSTextAlignmentLeft;
    _titleLbl.textColor = [UIColor whiteColor];

    
    CGFloat subY = CGRectGetMaxY(_titleLbl.frame);
    //子标题
    _subTitleLbl.frame = CGRectMake(offX, subY, w, 15);
    _subTitleLbl.text = _selectM.sub_title;
    _subTitleLbl.textColor = [UIColor whiteColor];
    _subTitleLbl.textAlignment = NSTextAlignmentLeft;
    _subTitleLbl.font = [UIFont boldSystemFontOfSize:13];

    
    //底部细节
      CGFloat wwY = CGRectGetMaxY(_subTitleLbl.frame) + kMargin;
    _bootomView.frame = CGRectMake(offX, wwY, w, 20);
    
    _bootomView.style = TLWhereWhenStyle;
    _bootomView.selectM = _selectM;
   
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
