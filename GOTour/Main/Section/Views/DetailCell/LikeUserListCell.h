//
//  LikeUserListCell.h
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReferrerModel;
@interface LikeUserListCell : UITableViewCell

@property (nonatomic,strong) ReferrerModel *referrer;

+ (instancetype)createTableView:(UITableView *)tableView;
@end
