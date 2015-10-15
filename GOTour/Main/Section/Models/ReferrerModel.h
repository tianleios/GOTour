//
//  ReferrerModel.h
//  旅行
//
//  Created by 磊 田 on 15/9/13.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface ReferrerModel : BaseModel

//"id":1569,
//"username":"solo在旅途",
//"photo_url":"http://data.qinker.com/image/avatar/7b/05/81/7b05818fb1bb5af6a8c79f53dec74991.png",
//"bg_pic":"http://data.qinker.com/image/avatar/64/cb/2d/64cb2d293b384485194b580441a784f8.jpg",
//"intro":"天天推荐旅游产品，心痒不行了，准备攒够了钱就辞职（别告诉我boss）",
//"fr_num":0,
//"fg_num":0,
//"prd_num":158,
//"album_count":null,
//"msg_num":0,
//"is_followed":0,
//"like_num":0,
//"type":3

//@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *userID;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *photo_url;
@property (nonatomic, copy) NSString *bg_pic;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, strong) NSNumber *fr_num;
@property (nonatomic, strong) NSNumber *fg_num;
@property (nonatomic, strong) NSNumber *prd_num;
@property (nonatomic, copy) NSString *album_count;
@property (nonatomic, strong) NSNumber *msg_num;
@property (nonatomic, strong) NSNumber *is_followed;
@property (nonatomic, strong) NSNumber *like_num;
@property (nonatomic, strong) NSNumber *type;

//-(instancetype)initWithDicitionary:(NSDictionary *)dict;

@end
