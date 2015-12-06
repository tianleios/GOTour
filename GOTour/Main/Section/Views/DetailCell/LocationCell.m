//
//  LocationCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "LocationCell.h"
#import "SelectModel.h"
@interface LocationCell()

@property (nonatomic, strong) UIButton *mapBut;
@property (nonatomic, strong) UILabel *adressLbl;
@end


@implementation LocationCell


+(instancetype)createCellWithModel:(SelectModel *)model mapBlock:(MapBlock)block;
{
    LocationCell *cell = [[LocationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.adressLbl.text =[NSString stringWithFormat:@" %@",model.address];
    cell.block = block;
    return cell;


}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _mapBut = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 4/5, 0, 60, 65)];
        self.layer.cornerRadius = 3;
        _mapBut.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_mapBut];
        [_mapBut setImage:[UIImage imageNamed:@"activity_map1.png"] forState:UIControlStateNormal];
        [_mapBut addTarget:self action:@selector(mapAction) forControlEvents:UIControlEventTouchUpInside];
        _adressLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 3/4 - 10, self.frame.size.height)];
        _adressLbl.numberOfLines = 2;
        _adressLbl.font = [UIFont systemFontOfSize:15];

        
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"activity_Tit.png"]];
        [self addSubview:_adressLbl];
        
    }
    return self;
    
}

- (void)mapAction
{

    _block();
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
