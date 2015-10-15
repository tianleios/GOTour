//
//  HeadCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "HeadCell.h"
#import "DetailModel.h"
#import "ContentModel.h"
@implementation HeadCell
{
    UIButton *_but;
}

+ (instancetype)createCellWith:(UITableView *)tableView
{
    static NSString *ID = @"headCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[HeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _but = [[UIButton alloc]init];
        _but.userInteractionEnabled = NO;
        
        [self addSubview:_but];
    }
    return self;
}

-(void)setFrameM:(DetailCellFrame *)frameM
{
    _frameM = frameM;
    NSString *str = frameM.detailM.content.head;
    [_but setTitle:str forState:UIControlStateNormal];

    _but.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _but.frame = _frameM.headFrame;;
    _but.titleLabel.lineBreakMode = 0;

    _but.titleLabel.textAlignment = NSTextAlignmentCenter;
    _but.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    [_but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
