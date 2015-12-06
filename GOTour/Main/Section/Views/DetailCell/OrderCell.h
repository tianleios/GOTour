//
//  OrderCell.h
//  GOTour
//
//  Created by 磊 田 on 15/10/18.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectModel;
typedef void(^GoBlock)(void);
@interface OrderCell : UITableViewCell

@property (nonatomic, strong) SelectModel *selectM;
@property (nonatomic, copy) GoBlock go;


+ (instancetype)createCellWithTableView:(UITableView *)tableView   model:(SelectModel *)model go:(GoBlock)go;
@end
