//
//  ReferrerCell.h
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferrerModel.h"
@interface ReferrerCell : UITableViewCell

@property (nonatomic, strong) ReferrerModel *referrer;

+ (instancetype)createCellWith:(UITableView *)tableView;

@end
