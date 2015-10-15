//
//  ExpenseModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/4.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface ExpenseModel : BaseModel

//"content":Array[2],
//"group"
@property (nonatomic, copy) NSString * group;
@property (nonatomic, strong) NSArray *content;

@end
