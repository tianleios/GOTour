//
//  DetailBootomCellFrame.h
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpenseModel.h"
#import "SelectModel.h"
@interface DetailBootomCellFrame : NSObject



@property (nonatomic, strong) SelectModel *selectM;

@property (nonatomic, assign) CGRect expenseCellFrame;
@property (nonatomic, assign) CGRect timeCellFrame;
@property (nonatomic, assign) CGRect orderCellFrame;



@property (nonatomic, assign) CGFloat expenseCellHeight;
@property (nonatomic, assign) CGFloat timeCellHeight;
@property (nonatomic, assign) CGFloat orderCellHeight;

@property (nonatomic, copy) NSString *expenseStr;

@end
