//
//  LastCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellAssessoryBut.h"
@interface LastCell : UITableViewCell

+(instancetype)createCell:(NSString *)title accessaryType:(BOOL)flag rightTitle:(NSString *)rightTitle action:(CellAccessoryBlock)block;
@end
