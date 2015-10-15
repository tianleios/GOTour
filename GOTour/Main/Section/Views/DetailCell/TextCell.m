//
//  TextCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TextCell.h"

#import "DetailModel.h"
#import "ContentModel.h"

@implementation TextCell
{
    UILabel *_lbl;

}

+ (instancetype)createCellWith:(UITableView *)tableView
{
    static NSString *ID = @"textCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbl = [[UILabel alloc]init];
        [self addSubview:_lbl];
        _lbl.font = kDetailTextFont;
      
    }
    return self;
}

-(void)setFrameM:(DetailCellFrame *)frameM
{
    _frameM = frameM;
 
    
    _lbl.frame = frameM.textFrame;
    _lbl.text =[NSString stringWithFormat:@"%@", _frameM.detailM.content.text];
   
    _lbl.numberOfLines = 0;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
