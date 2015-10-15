//
//  TimeCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailBootomCellFrame.h"

@interface TimeCell : UITableViewCell

+ (instancetype)createCellWith:(DetailBootomCellFrame *)frameModel;

@property (nonatomic, strong) DetailBootomCellFrame *frameModel;

@end
