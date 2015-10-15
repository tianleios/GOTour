//
//  TimeCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TimeCell.h"

@implementation TimeCell
{

    UILabel *_lbl;
}
+ (instancetype)createCellWith:(DetailBootomCellFrame *)frameModel
{
    TimeCell *cell = [[TimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.frameModel = frameModel;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:nil]) {
        
        _lbl = [[UILabel alloc]initWithFrame:self.frame];
        [self addSubview:_lbl];
        _lbl.numberOfLines = 0;
        _lbl.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)setFrameModel:(DetailBootomCellFrame *)frameModel
{
    _frameModel = frameModel;
    _lbl.text = _frameModel.selectM.schedule;
    _lbl.frame = _frameModel.timeCellFrame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
