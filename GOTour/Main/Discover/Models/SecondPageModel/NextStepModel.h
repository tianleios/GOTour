//
//  NextStepModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/8.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface NextStepModel : BaseModel

//"id":1,
//"title":"巴塞罗那球迷狂欢",
//"sub_title":"",
//"bg_pic":"http://data.qinker.com/image/original/09/55/06/095506f8a9399feffbe829cb29e4092c.jpg",
//"bg_color":7698036,
//"body":Array[58],
//"author

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *sub_title;
@property (nonatomic, copy) NSString *bg_pic;
@property (nonatomic, strong) NSArray *body;

@end
