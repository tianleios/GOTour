//
//  TLHTTPTool.m
//  旅行
//
//  Created by 磊 田 on 15/10/6.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLHTTPTool.h"
#import "AFNetworking.h"
#import "FMDB.h"
#import "SelectModel.h"
/**
 * 首页数据
 */
#define kBaseHomeUrl @"http://appsrv.flyxer.com/api/digest/main?did=14488&page=1&v=2&qid=0"

typedef void(^SuccessBlock)(id responseObject);
@implementation TLHTTPTool

static FMDatabase *_db;

+(void)initialize
{
    //创建数据库
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [str stringByAppendingPathComponent:@"like.sqlite"];
    
    _db = [FMDatabase databaseWithPath:path];
    
    if ([_db open]) {
        NSLog(@"打开数据库成功");
    }else{
        
        NSLog(@"打开数据库失败");

    }
    
    BOOL bl = [_db executeUpdateWithFormat:@"create table if not exists t_like(id integer primary key autoincrement not null,identify text not null,detail bolb not null,image bolb not null) ;"];
    
    if (bl) {
        NSLog(@"创建数据库成功");
    }else{
        NSLog(@"创建数据库失败");

    }
    NSLog(@"%@",NSHomeDirectory());
}

//删除数据
+ (void)deleteDataByID:(NSNumber *)ID
{
    if ([_db goodConnection]) {
        
        NSString *str = [ID stringValue];
        BOOL bl = [_db executeUpdateWithFormat:@" delete from t_like where identify = %@ ;",str];
        if (bl) {
            NSLog(@"删除成功");
        }else{
            
            NSLog(@"删除失败");
        }

    }else{
        [_db open];
    
        NSString *str = [ID stringValue];
        BOOL bl = [_db executeUpdateWithFormat:@" delete from t_like where identify = %@ ;",str];
        if (bl) {
            NSLog(@"删除成功");
        }else{
            
            NSLog(@"删除失败");
        }

    }
    
    [_db close];
  
}

//保存数据
+ (void)saveDataWithModel:(id)model imageV:(UIImageView *)imageV
{
    SelectModel *_selectM = model;
    NSMutableDictionary *dict = [_selectM keyValues];

    NSData *detailData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    //数据 转换
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:imageV.image];

    NSString *identify = [_selectM.ID stringValue];
    NSLog(@"identify%@",identify);
    
    if ([_db goodConnection]) {
        
        //进行数据存储
        BOOL isSave = [_db executeUpdateWithFormat:@" insert into t_like(identify, detail,image) values(%@,%@,%@);",identify,detailData,imageData];
        
        if (isSave) {
            NSLog(@"保存成功");
        }else{
            NSLog(@"保存失败");
        }
     FMResultSet *set = [_db executeQuery:@"select * from t_like;"];
        if ([set next]) {
            NSLog(@"haoduo");
        }
    }else{
        [_db open];
        BOOL isSave = [_db executeUpdateWithFormat:@" insert into t_like(identify, detail,image) values(%@,%@,%@);",identify,detailData,imageData];
        
        if (isSave) {
            NSLog(@"保存成功");
        }else{
            NSLog(@"保存失败");
        }
        
       }
    [_db close];
}
/**
 * 通过数据库获取数据
 */
+ (NSMutableArray *)getDataFromDB
{
    if ([_db goodConnection]) {
        
     return [TLHTTPTool findData];
        
    }else{
        [_db open];
        
        return [TLHTTPTool findData];
    }
    
    return nil;
}
+ (NSMutableArray *)findData
{
    FMResultSet *result = [_db executeQuery:@"SELECT * FROM t_like"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    if ([result next]) {
        NSLog(@"几次啊");
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        
        NSData *imageData = [result dataForColumn:@"image"];
        NSData *detailData = [result dataForColumn:@"detail"];
        
        UIImage *image = (UIImage *)[NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        dict[@"image"] =image;
        //图片
        NSDictionary *modelDict = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:detailData];
        //模型
        dict[@"selectM"] = [SelectModel objectWithKeyValues:modelDict];
        [array addObject:dict];
        
    }
    NSLog(@"%d数据库中",array.count);
    [_db close];
    return array;
}

- (void)objectDidFinishConvertingToKeyValues
{
   //转换成功

}

/**
 * 请求数据本地或者网络
 */
+ (void)requestHomeDataSuccess:(void(^)(id responseObject))success fail:(void(^)(id error))fail
{
    //先判断从数据库里区数据 还是从网络加载数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:kBaseHomeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) {
            
            fail(error);
        }
    }];



}
+ (void)requestDataWithUrl:(NSString *)urlString parameters:(NSDictionary *)dict  success:(void(^)(id responseObject))successBlock fail:(void(^)(id responseObject))failBlock
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置请求超时时间
    manager.requestSerializer.timeoutInterval = 10.0;
    
    [manager GET:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failBlock(error);
        
    }];
    


}
@end
