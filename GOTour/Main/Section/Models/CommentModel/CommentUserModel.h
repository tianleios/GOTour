//
//  CommentUserModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"

@interface CommentUserModel : BaseModel

//"name":"qq.(null).1416281910.65",
////    "avatar":"",
////    "id":137
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSNumber *IDUser;

@end
