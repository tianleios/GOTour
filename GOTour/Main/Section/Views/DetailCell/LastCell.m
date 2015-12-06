//
//  LastCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "LastCell.h"

@implementation LastCell

+(instancetype)createCell:(NSString *)title accessaryType:(BOOL)flag rightTitle:(NSString *)rightTitle action:(CellAccessoryBlock)block
{
    static NSString *ID = @"lastCell";
    
    LastCell *cell = [[LastCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];

    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(2*kMargin, 12.5, kMargin, 15)];
    [cell addSubview:iv];
    iv.image = [UIImage imageNamed:@"activity_red"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
   
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 20)];
    lbl.text = title;
    [cell addSubview:lbl];
    
    
    cell.detailTextLabel.text = rightTitle;
    cell.detailTextLabel.textColor = [UIColor redColor];
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"activity_Tit.png"]];
    
   CellAssessoryBut *but = [[CellAssessoryBut alloc]initWithFrame:CGRectMake(0, 0, 30, 30) withType:flag];
//    but.backgroundColor = [UIColor redColor];
    but.block = block;
   
    
    cell.accessoryView = but;

   
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
