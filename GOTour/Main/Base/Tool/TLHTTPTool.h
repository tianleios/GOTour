//
//  TLHTTPTool.h
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLHTTPTool : NSObject<MJKeyValue>


/**
 * 根据收到的模型进行存储数据
 */

+ (void)saveDataWithModel:(id)model imageV:(UIImageView *)imageV;
/**
 * 取出存储的数据
 */
+ (NSMutableArray *)getDataFromDB;

/**
 * 删除数据
 */

+ (void)deleteDataByID:(NSNumber *)ID;
/**
 * 首页封装的请求数据操作
 */
+ (void)requestHomeDataSuccess:(void(^)(id responseObject))success fail:(void(^)(id error))fail;

+ (void)requestDataWithUrl:(NSString *)urlString parameters:(NSDictionary *)dict success:(void(^)(id responseObject))successBlock fail:(void(^)(id error))failBlock;

/**
 *  bianxie
 */
@end
