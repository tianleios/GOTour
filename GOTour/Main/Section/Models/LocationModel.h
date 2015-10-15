//
//  LocationModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/11.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel

@property (nonatomic, strong) NSNumber *lat; //维度
@property (nonatomic, strong) NSNumber *lng; //径度

@end
