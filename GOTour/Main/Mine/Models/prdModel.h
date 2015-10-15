//
//  prdModel.h
//  GOTour
//
//  Created by 磊 田 on 15/10/14.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface prdModel : BaseModel

//count":4,
//"results"
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSArray *results;

@end
