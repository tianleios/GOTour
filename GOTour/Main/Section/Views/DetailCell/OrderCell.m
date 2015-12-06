//
//  OrderCell.m
//  GOTour
//
//  Created by 磊 田 on 15/10/18.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "OrderCell.h"
#import "NSString+Ext.h"
#import "SelectModel.h"
@interface OrderCell()

@property (nonatomic,weak) UILabel *phoneLbl;
@property (nonatomic,weak) UILabel *webLbl;
@property (nonatomic,weak) UIView *line;

@property (nonatomic,weak) UIButton *webBut;

@end

@implementation OrderCell
+ (instancetype)createCellWithTableView:(UITableView *)tableView   model:(SelectModel *)model go:(GoBlock)go
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectM = model;
    cell.go = go;
    return cell;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lbl0 = [[UILabel alloc] init];
        [self.contentView addSubview:lbl0];
        self.phoneLbl = lbl0;
        
        UILabel *lbl1 = [[UILabel alloc] init];
        [self.contentView addSubview:lbl1];
        self.webLbl = lbl1;
        
        UIView *vi = [[UIView alloc] init];
        [self.contentView addSubview:vi];
        _line = vi;
        
        UIButton *but = [[UIButton alloc] init];
        [but setImage:[UIImage imageNamed:@"activity_RightAccessory"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
        _webBut = but;
        
    }
    return self;
}

-(void)setSelectM:(SelectModel *)selectM
{
    _selectM = selectM;
    
    CGSize size = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 3*kMargin, MAXFLOAT) string:_selectM.contact font:[UIFont systemFontOfSize:15]];
    
    _phoneLbl.text = selectM.contact;
    _phoneLbl.frame = CGRectMake(kMargin*2, kMargin*2, kScreenWidth - 2*kMargin, size.height);
    
    _phoneLbl.numberOfLines = 0;
    _phoneLbl.font = [UIFont systemFontOfSize:15];
    //分割线
    
    CGFloat y1 = CGRectGetMaxY(_phoneLbl.frame);
    _line.frame = CGRectMake(kMargin, y1 +kMargin, kScreenWidth - 3*kMargin, 2);
    _line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    //网站
    CGFloat y2 = CGRectGetMaxY(_line.frame);
    NSString *str = [self webUrlString:_selectM.order_url];
    _webLbl.text =[NSString stringWithFormat:@"在线预订：%@",str];
    _webLbl.frame = CGRectMake(kMargin*2, y2 + kMargin, kScreenWidth - 11*kMargin, 20) ;

    _webLbl.font = [UIFont systemFontOfSize:12];
    
    //按钮
    _webBut.frame = CGRectMake(kScreenWidth - 9*kMargin, y2 + kMargin, 20, 20);
    
    

}
- (NSString *)webUrlString:(NSString *)str
{
    NSRange range = [str rangeOfString:@".com"];
    
    return [str substringToIndex:range.location+range.length];

}
- (void)action
{
    _go();

}
@end
