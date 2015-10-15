//
//  MainCollectionModel.h
//  旅行
//
//  Created by 磊 田 on 15/9/19.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface MainCollectionModel : BaseModel
//"type":"Collection",
//"num":3,
//"collections":Array[3]
//},
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSNumber *num;


//@property (nonatomic, strong) NSMutableArray *clmArray;
//
//-(instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic, strong) NSArray *collectionArray;

@end
