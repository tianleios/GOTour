//
//  CommentModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"
#import "CommentModel.h"
@interface CommentModel : BaseModel

//"count":3,
//"next":null,
//"previous":null,
//"results":Array[3]

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, copy) NSString *next;
@property (nonatomic, copy) NSString *previous;
@property (nonatomic, strong) NSArray *results;

@end
