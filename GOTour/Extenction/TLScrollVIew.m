//
//  TLScrollVIew.m
//  旅行
//
//  Created by 磊 田 on 15/9/19.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLScrollVIew.h"
#import "MainCollectionModel.h"
#import "CollectionModel.h"

#import "TopSelectionModel.h"
@implementation TLScrollVIew
{
//    UILabel *lableTitle;
//    UILabel *lableSub;
    

}
-(void)dealloc
{
//    [_timer invalidate];
//    NSLog(@"——————————定时器销毁");

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _last = 0;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.userInteractionEnabled = NO;
       
 
         }
    return self;
}

-(void)scrollAction
{
    
    if (_last < _pageNum) {
        
        [self setContentOffset:CGPointMake(_last*kScreenWidth, 0) animated:YES];

        _last ++;
        
    }else
    {
        _last = 0;
    
    }
    
    
}

//-(void)setMainCollectionModel:(MainCollectionModel *)mainCollectionModel
//{
////    if (mainCollectionModel != nil) {
//        _mainCollectionModel = mainCollectionModel;
//    
//    NSMutableArray *urlArray = [[NSMutableArray alloc]initWithCapacity:_mainCollectionModel.collectionArray.count];
//    
//    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithCapacity:_mainCollectionModel.collectionArray.count];
//    
//    NSMutableArray *subTitleArray = [[NSMutableArray alloc]initWithCapacity:_mainCollectionModel.collectionArray.count];
//    
//    for (CollectionModel *tempModel in  _mainCollectionModel.collectionArray) {
//        
//        NSString *str = tempModel.bg_pic[0];
//        
////        if ([tempModel.title_notshown  isEqual: @0]) {
//        
//            NSString *str1 = tempModel.title;
//            NSString *str2 = tempModel.sub_title;
//            
//            [titleArray addObject:str1];
//            [subTitleArray addObject:str2];
//            
////        }
//        
//        [urlArray addObject:str];
//        
//    }
//    
//    self.titleArray = titleArray;
//    self.subTitleArray = subTitleArray;
//    self.URLArray = urlArray;
//    
////}
//
//
//
//}


-(void)setURLArray:(NSArray *)URLArray
{
    
    _URLArray = [URLArray copy];
    _pageNum = _URLArray.count;
   
    for (int i = 0; i < _pageNum; i ++) {
        
        self.contentSize = CGSizeMake(_pageNum * kScreenWidth, 0);

        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, bigImageHeight)];
        
        NSURL *url = [NSURL URLWithString:_URLArray[i]];
        
//        [imgView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
            
            
//        }];
        
        
        [imgView  sd_setImageWithURL:url  placeholderImage:nil];
        
//        [UIImage imageNamed:@"home_prospect_tb.png"]
        

            //添加图片上的标题
        CollectionModel *tempModel =  _mainCollectionModel.collectionArray[i];
        if ([tempModel.title_notshown  isEqual: @0]) {
            
                
           UILabel * lableTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, bigImageHeight*2/5, kScreenWidth, 35)];
            lableTitle.textColor = [UIColor whiteColor];
            lableTitle.backgroundColor = [UIColor clearColor];
            lableTitle.font = [UIFont boldSystemFontOfSize:25];

            lableTitle.text = _titleArray[i];
            
            lableTitle.textAlignment = NSTextAlignmentCenter;
            [imgView addSubview:lableTitle];
//            imgView.image = [self addText:imgView.image text:_subTitleArray[i]];

//        }
    
         CGFloat y = CGRectGetMaxY(lableTitle.frame);
        //有子标题添加子标题
        
        if (_subTitleArray.count != 0) {
               
            
                
               UILabel * lableSub = [[UILabel alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 20)];
            
               lableSub.textColor = [UIColor whiteColor];
               lableSub.backgroundColor = [UIColor clearColor];
               lableSub.textAlignment = NSTextAlignmentCenter;
               lableSub.font = [UIFont boldSystemFontOfSize:15];
               //是否加载图片文字

               lableSub.text = _subTitleArray[i];
            
               [imgView addSubview:lableSub];
       }
       
    }

        
        
        [self addSubview:imgView];
    }
    
    if (_URLArray.count > 1) {
        
        if (_timer == nil) {
            
       NSLog(@"你好");
        if (_interval == 0) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
         
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
        else{
           _timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
            
        }
    }
   
    
}
- (void)addtitle:(UIImage *)image
{



}
- (UIImage *) addText:(UIImage *)img text:(NSString *)mark {
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [[UIColor redColor] set];
    [img drawInRect:CGRectMake(0, 0, w, h)];
//    [mark drawInRect:CGRectMake(10, 55, 130, 80) withFont:[UIFont systemFontOfSize:18]];
    NSDictionary *attribute = @{
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:15],
                                NSForegroundColorAttributeName : [UIColor whiteColor]
                                
                                };
    [mark drawInRect:CGRectMake(0, bigImageHeight*2/5, kScreenWidth, 35) withAttributes:attribute];
//    [mark drawInRect:CGRectMake(10, 55, 130, 80) withAttributes:(nullable NSDictionary<NSString *,id> *)];
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
    
}


@end
