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

/**
 * 是否从数据库加载的标志
 */
static int _flag;
static FMDatabase *_db;

+(void)initialize
{
    //
    _flag = 0;
    
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
           
        NSLog(@"创建收藏成功");
           
    }else{
        NSLog(@"创建收藏失败");

    }
    
    BOOL blMain = [_db executeUpdateWithFormat:@"create table if not exists t_main(id integer primary key autoincrement not null,name text not null, main bolb not null)"];
    
    if (blMain) {
        
        NSLog(@"创建主页表成功");
        
    }else{
        
        NSLog(@"创建主页表失败");
        
    }
    

}

//删除数据
+ (void)deleteDataByID:(NSNumber *)ID
{
//    NSLog(@"ID%@",ID);
    BOOL bl = [_db executeUpdateWithFormat:@"delete from t_like where identify = %@;",ID];

    if (bl) {
        
        NSLog(@"删除成功");
        
    }else{
        
        NSLog(@"删除失败");
    }

    
}

//保存数据
+ (void)saveDataWithModel:(id)model imageV:(UIImageView *)imageV
{
    SelectModel *_selectM = model;
    NSMutableDictionary *dict = [_selectM keyValues];

    NSData *detailData = [NSKeyedArchiver archivedDataWithRootObject:dict];
//    数据 转换
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:imageV.image];

      NSString *identify = [_selectM.ID stringValue];

//    NSLog(@"identify%@",identify);
    
    
        //进行数据存储
        BOOL isSave = [_db executeUpdateWithFormat:@" insert into t_like(identify, detail,image) values(%@,%@,%@);",identify,detailData,imageData];
    
    
        if (isSave) {
            NSLog(@"保存成功");
        }else{
            NSLog(@"保存失败");
        }

}
/**
 * 通过数据库获取数据
 */
+ (NSMutableArray *)getDataFromDB
{
    FMResultSet *result1 = [_db executeQuery:@"SELECT * FROM t_like "];
    
    NSMutableArray *array = [NSMutableArray array];
    
    
    while ([result1 next]) {
   
       
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        
        NSData *imageData = [result1 dataForColumn:@"image"];
        NSData *detailData = [result1 dataForColumn:@"detail"];
        
        UIImage *image = (UIImage *)[NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        dict[@"image"] =image;
        //图片
        NSDictionary *modelDict = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:detailData];
        //模型
        SelectModel *model = [SelectModel objectWithKeyValues:modelDict];
        dict[@"selectM"] = model;
        dict[@"identify"] = [result1 stringForColumn:@"identify"];
//        NSLog(@"%@",dict[@"identify"]);
        [array addObject:dict];

    }
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
    
    //判读 第一次进入程序 加载数据从 数据库中记载 以后刷新 就请求网络数据
    if (_flag < 1 ) {
        
        //先从数据库下载
        FMResultSet *mainResult = [_db executeQuery:@"select *from t_main where name='store';"];
        
        if ([mainResult next]) {
            NSLog(@"从数据库中下载数据");
          NSData *data = [mainResult dataForColumn:@"main"];
          success([NSKeyedUnarchiver unarchiveObjectWithData:data]);
            _flag ++;
        }else{
            
            //从网络上请求数据
            NSLog(@"从网络中下载，进行存储");
            [self requestDataFromNet:success fail:fail isHasData:YES];
            
        }
        
    }else{
      NSLog(@"从网络中下载，不进行存储");
      [self requestDataFromNet:success fail:fail isHasData:NO];
        
    }
    
}

+ (void)requestDataFromNet:(void(^)(id responseObject))success fail:(void(^)(id error))fail isHasData:(BOOL)flag
{
    //如果数据库没有 从网络进行加载
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    [manager GET:kBaseHomeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _flag ++;
        
            if(success)
            {
                success(responseObject);
                
            }
        
        //判断数据库中是否有数据 若果没有
            //加载成功了进行存储
        if (flag) {
            NSData *mainData = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
            BOOL isInsert = [_db executeUpdateWithFormat:@"insert into t_main(name,main) values(%@,%@)",@"store",mainData];
            
            if (isInsert == YES) {
                
                NSLog(@"插入数据库成功");
                
            }else{
                
                NSLog(@"插入数据库失败");
            }

            
        }else{
            
            NSData *mainData = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
//            NSLog(@"_____%@",mainData);
            BOOL isInsert = [_db executeUpdateWithFormat:@"update t_main set main= %@ where name=%@;",@"store",mainData];
            
            if (isInsert == YES) {
                
                NSLog(@"更新数据库成功%@",NSHomeDirectory());
                
            }else{
                
                NSLog(@"更新数据库失败%@",NSHomeDirectory());
            }
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
