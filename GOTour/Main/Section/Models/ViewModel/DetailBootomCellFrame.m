//
//  DetailBootomCellFrame.m
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "DetailBootomCellFrame.h"
#import "NSString+Ext.h"
@implementation DetailBootomCellFrame
{
 NSArray *_expense;

}
-(void)setSelectM:(SelectModel *)selectM
{
    _selectM = selectM;
    //花费
    _expense = selectM.expense;
    [self expense];
    
    //时间
    _timeCellHeight = 60;
    _timeCellFrame = CGRectMake(10, kMargin, kScreenWidth - 20, 40);
    
    //电话网站
    
  CGSize size = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 3*kMargin, MAXFLOAT) string:_selectM.contact font:[UIFont systemFontOfSize:15]];
    _orderCellHeight = size.height + 45;
    
    
}
-(void)expense
{
    
    
    
    //字符串的拼接
    NSMutableString *string = [NSMutableString string];
    for (ExpenseModel *model in _expense) {
        [string appendString:@"\n"];
        [string appendString:model.group];
        [string appendString:@"\n"];
        
        for (NSString *str in model.content) {
            [string appendString:str];
            [string appendString:@"\n"];
        }
    }
    _expenseStr = string;
    
    CGSize size = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT) string:string font:[UIFont systemFontOfSize:15]];
    CGFloat y = size.height ;
    _expenseCellFrame = CGRectMake(20, 0 , kScreenWidth - 40, y);
    _expenseCellHeight = y;
    
    
    

    
}
@end
