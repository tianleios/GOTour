//
//  DetailModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/3.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDetailCellMargin 15
#import "BaseModel.h"
#import "ContentModel.h"

@interface DetailModel : BaseModel


@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) ContentModel *content;
@end
