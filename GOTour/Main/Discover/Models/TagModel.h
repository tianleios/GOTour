//
//  TagModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface TagModel : BaseModel

//"id":18,
//"name":"飞行",
//"icon":"http://data.qinker.com/image/original/09/1e/29/091e2985662fb9ea9f59f55e5ff29ef5.png"
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;


@end
