//
//  LikeUserListCell.m
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "LikeUserListCell.h"

#import "ReferrerModel.h"
@interface LikeUserListCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;


@end

@implementation LikeUserListCell
+ (instancetype)createTableView:(UITableView *)tableView
{
    LikeUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[LikeUserListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _icon = [[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        
        _subTitle = [[UILabel alloc] init];
        [self.contentView addSubview:_subTitle];
    }
    return self;
}
- (void)setReferrer:(ReferrerModel *)referrer
{
    CGFloat w = 40;


    _referrer = referrer;
    _icon.frame = CGRectMake(kMargin, kMargin, w, w);
    _icon.layer.cornerRadius = w/2;
    _icon.layer.masksToBounds = YES;
    [_icon sd_setImageWithURL:[NSURL URLWithString:_referrer.photo_url] placeholderImage:[UIImage imageNamed:@"defaultavatar.png"]];

    _title.frame = CGRectMake(w + 2*kMargin , kMargin , kScreenWidth - w - 2*kMargin , w/2);
    
    _title.text = _referrer.username;
    NSLog(@"_referrer.username%@",_referrer.username);

    NSLog(@"_title.text%@",_title.text);
 
    _subTitle.frame = CGRectMake(w +2*kMargin , kMargin + w/2 , kScreenWidth - w - 2*kMargin , 15);
    _subTitle.text = _referrer.intro;
    _subTitle.font = [UIFont systemFontOfSize:13];

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 55-1, kScreenWidth, 1)];
    v.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
//
    [self.contentView addSubview:v];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
