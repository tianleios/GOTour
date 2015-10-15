//
//  CollectionCell1.h
//  tianleilnl
//
//  Created by 磊 田 on 15/10/11.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SelectFrame.h"

@class TLScrollVIew;



@interface CollectionCell1 : UITableViewCell

@property (nonatomic, weak) TLScrollVIew *scrollV;
@property (nonatomic, strong) SelectFrame *selectFrame;

+ (instancetype)createCelllWithTableView:(UITableView *)tableView;

@end
