//
//  CollectionCell1.m
//  tianleilnl
//
//  Created by 磊 田 on 15/10/11.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "CollectionCell1.h"

#import "MainCollectionModel.h"
#import "TLScrollVIew.h"

@interface CollectionCell1()




@end
@implementation CollectionCell1

+ (instancetype)createCelllWithTableView:(UITableView *)tableView
{
    CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cCell"];
    
    if (cell == nil) {
        
        cell= [[CollectionCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        TLScrollVIew *s = [[TLScrollVIew alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
         [self addSubview:s];
        _scrollV = s;
    }
    
    return self;
    
}

-(void)setSelectFrame:(SelectFrame *)selectFrame
{
    [_scrollV.timer invalidate];
    _selectFrame = selectFrame;
    _scrollV.frame = _selectFrame.scrrollFrame;

    MainCollectionModel *mColModel =_selectFrame.mainCM;
    
    _scrollV.mainCollectionModel = mColModel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
