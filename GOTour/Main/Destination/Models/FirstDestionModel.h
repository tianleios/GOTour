//
//  FirstDestionModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface FirstDestionModel : BaseModel
//"id":6539,
//"name":"日本",
//"bg_pic":"http://data.qinker.com/image/original/c6/f1/23/c6f123f44998af23c3d8e4fc166eb6e6.jpg",
//"bg_color":7629420,
//"desc"



@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *bg_pic;
@property (nonatomic, strong) NSNumber *bg_color;

@property (nonatomic, copy) NSString *desc;
@end
