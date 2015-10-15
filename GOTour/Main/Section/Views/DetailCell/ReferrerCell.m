//
//  ReferrerCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ReferrerCell.h"
#import "ContentModel.h"
#import "DetailModel.h"
@interface ReferrerCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *lable;

@end

@implementation ReferrerCell

+ (instancetype)createCellWith:(UITableView *)tableView
{
    static NSString *ID = @"referrer";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ReferrerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
           }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageV   = [[UIImageView alloc]init];
        _imageV.layer.cornerRadius = 25;
        _imageV.layer.masksToBounds = YES;
        _imageV.contentMode =  UIViewContentModeScaleAspectFill;
        _imageV.frame = CGRectMake(kScreenWidth/2 - 25, 10, 50, 50);
        
        _lable  = [[UILabel alloc]init];
        
        
        [self addSubview:_imageV];
        [self addSubview:_lable];

       
    }
    return self;
}

-(void)setReferrer:(ReferrerModel *)referrer
{
    _referrer = referrer;
    
    _lable.text = _referrer.username;
//    _lable.backgroundColor = [UIColor redColor];
    _lable.font = [UIFont systemFontOfSize:17];
    _lable.textAlignment = NSTextAlignmentCenter;
    
    _lable.frame = CGRectMake(0,65, kScreenWidth,18);

    NSURL *url = [NSURL URLWithString:referrer.photo_url];
    
    [_imageV sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
