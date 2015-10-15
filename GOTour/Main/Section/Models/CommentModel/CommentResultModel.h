//
//  CommentResultModel.h
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "BaseModel.h"
#import "CommentUserModel.h"
@interface CommentResultModel : BaseModel

//id":449,
//"text":"DVDs",
//"timestamp":"2015-10-05T15:20:11",
//"user":{
//    "name":"qq.(null).1416281910.65",
//    "avatar":"",
//    "id":137
//},
//"to_who":""
@property (nonatomic, strong) NSNumber *commentID;
@property (nonatomic, copy ) NSString *text;
@property (nonatomic, copy ) NSString *timestamp;
@property (nonatomic, strong) CommentUserModel *user;
@property (nonatomic, copy ) NSString *to_who;

@end
