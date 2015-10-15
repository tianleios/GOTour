//
//  TopSelectionModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"
#import "SelectionModel.h"
@interface TopSelectionModel : BaseModel
//"type":"R",
//"hotness":73,
//"selection
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSNumber *hotness;
@property (nonatomic, strong) SelectionModel *selection;



@end
