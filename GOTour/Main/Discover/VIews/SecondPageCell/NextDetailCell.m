//
//  NextDetailCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "NextDetailCell.h"
#import "TLTitleView.h"
#import "ContentModel.h"
@interface NextDetailCell()

@property (nonatomic, strong) TLTitleView *titleView;
@property (nonatomic, weak) UIButton *nextBut;
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *subTitleLbl;

@end
@implementation NextDetailCell

+ (instancetype)createCellWithTableView:(UITableView *)tableView block:(NextBlock) block
{
    NextDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nextDetail"];
    if (cell == nil) {
        cell = [[NextDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nextDetail"];
    }
    cell.nextBlock = block;
    return cell;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //图片
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        _imageV.userInteractionEnabled = YES;
        
        _titleLbl = [[UILabel alloc]init];
        [_imageV addSubview:_titleLbl];
        
        _subTitleLbl = [[UILabel alloc] init];
        [_imageV addSubview:_subTitleLbl];
        
    }

    return self;
}
- (void)setFrameM:(DetailCellFrame *)frameM
{
    _frameM = frameM;
    
    _detailModel = frameM.detailM;
    
    ContentModel *model = _detailModel.content;
    
    _imageV.frame = _frameM.nextImageFrame;
    
    NSURL *url = [NSURL URLWithString:model.bg_pic];
    [_imageV sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
    
    //标题
    CGFloat w = _imageV.frame.size.width;
    CGFloat h = _imageV.frame.size.height;

   
    _titleLbl.frame = CGRectMake(0,h*0.7, w, 30);
    _titleLbl.text = model.title;
    _titleLbl.font = [UIFont boldSystemFontOfSize:20];
    _titleLbl.textAlignment = NSTextAlignmentLeft;
    _titleLbl.textColor = [UIColor whiteColor];
    _titleLbl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

    
    CGFloat subY = CGRectGetMaxY(_titleLbl.frame);
    //子标题
    _subTitleLbl.frame = CGRectMake(0, subY, w, 20);
    _subTitleLbl.text = model.sub_title;
    _subTitleLbl.textColor = [UIColor whiteColor];
    _subTitleLbl.textAlignment = NSTextAlignmentLeft;
    _subTitleLbl.font = [UIFont boldSystemFontOfSize:14];
    _subTitleLbl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];

    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(w-40, h - 50, 40, 40)];
    but.contentMode = UIViewContentModeScaleToFill;
    [but addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
//    _nextBut.frame = CGRectMake(w-40, h - 40, 40, 40);
    _nextBut = but;
    [but setImage:[UIImage imageNamed:@"activity_RightAccessory"] forState:UIControlStateNormal];
    [_imageV addSubview:but];
//    _nextBut.backgroundColor = [UIColor redColor];

}
- (void)nextAction
{
    _nextBlock();

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
